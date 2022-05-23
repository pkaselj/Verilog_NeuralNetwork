`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:27:16 04/12/2022 
// Design Name: 
// Module Name:    AddressGenerator 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module AddressGenerator
#(
	parameter IP_DATA_BUS_WIDTH = 16,
	parameter NEURON_ADDRESS_BUS_WIDTH = 8,
	parameter WEIGHTS_ADDRESS_BUS_WIDTH = 16
)(
input [IP_DATA_BUS_WIDTH - 1:0] Nk,
input [WEIGHTS_ADDRESS_BUS_WIDTH - 1:0] read_weight_base_addr,
input [NEURON_ADDRESS_BUS_WIDTH - 1:0] read_neuro_base_addr, write_neuro_base_addr,
input clk, reset, read,
output finished, neuron_finished,
output [WEIGHTS_ADDRESS_BUS_WIDTH - 1:0] weight_read_addr,
output [NEURON_ADDRESS_BUS_WIDTH - 1:0] neuro_read_addr, neuro_write_addr,
output [IP_DATA_BUS_WIDTH - 1:0] current_layer_size, previous_layer_size
);

/*
localparam
	W_R_BASE = 8'h00,
	N_R_BASE = 8'h00,
	N_W_BASE = 8'h00;
*/

reg [WEIGHTS_ADDRESS_BUS_WIDTH - 1:0] W_R_BASE;
reg [NEURON_ADDRESS_BUS_WIDTH - 1:0] N_R_BASE, N_W_BASE;
reg [IP_DATA_BUS_WIDTH - 1:0] internal_Nk, internal_Nk_1;
reg [WEIGHTS_ADDRESS_BUS_WIDTH - 1:0] ctrWR;
reg [NEURON_ADDRESS_BUS_WIDTH - 1:0] ctrVR, ctrVW;
wire [NEURON_ADDRESS_BUS_WIDTH - 1:0] next_ctrVR, next_ctrVW;
wire ctrVR_Overflow;

assign current_layer_size = internal_Nk;
assign previous_layer_size = internal_Nk_1;

assign finished = (ctrVR == internal_Nk_1 - 1) && (ctrVW == internal_Nk - 1);
assign neuron_finished = ctrVR_Overflow;
assign ctrVR_Overflow = ctrVR == internal_Nk_1 - 1;
assign next_ctrVR = (ctrVR_Overflow) ? 0 : ctrVR + 1;
assign next_ctrVW = (ctrVR_Overflow) ? ctrVW + 1 : ctrVW;

assign weight_read_addr = W_R_BASE + ctrWR;
assign neuro_read_addr = N_R_BASE + ctrVR;
assign neuro_write_addr = N_W_BASE + ctrVW;

initial begin
	W_R_BASE = 0;
	N_R_BASE = 0;
	N_W_BASE = 0;
	internal_Nk = 0;
	internal_Nk_1 = 0;
end

always @(posedge clk) begin
	if(reset) begin
		W_R_BASE <= 0;
		N_R_BASE <= 0;
		N_W_BASE <= 0;
	end else if(read) begin
		W_R_BASE <= read_weight_base_addr;
		N_R_BASE <= read_neuro_base_addr;
		N_W_BASE <= write_neuro_base_addr;
	end else if(finished) begin
		W_R_BASE <= weight_read_addr + 1;
		N_R_BASE <= neuro_read_addr + 1;
		N_W_BASE <= neuro_write_addr + 1;
	end
end

always @(posedge clk) begin
	if(reset) begin
		internal_Nk <= 0;
		internal_Nk_1 <= 0;
	end else if (read) begin
		internal_Nk <= Nk;
		internal_Nk_1 <= internal_Nk;
	end
end

always @(posedge clk) begin
	if(reset || read || finished) begin
		ctrWR <= 0;
		ctrVR <= 0;
		ctrVW <= 0;
	end else begin
		ctrWR <= ctrWR + 1;
		ctrVR <= next_ctrVR;
		ctrVW <= next_ctrVW;
	end
end

endmodule
