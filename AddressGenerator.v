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
module AddressGenerator(
input [7:0] Nk,
input [7:0] read_weight_base_addr, read_neuro_base_addr, write_neuro_base_addr,
input clk, reset, read,
output finished, neuron_finished,
output [7:0] weight_read_addr, neuro_read_addr, neuro_write_addr
);

/*
localparam
	W_R_BASE = 8'h00,
	N_R_BASE = 8'h00,
	N_W_BASE = 8'h00;
*/

reg [7:0] W_R_BASE, N_R_BASE, N_W_BASE;
reg [7:0] internal_Nk, internal_Nk_1;
reg [7:0] ctrWR, ctrVR, ctrVW;
wire [7:0] next_ctrVR, next_ctrVW;
wire ctrVR_Overflow;

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
	end else if (read) begin
		W_R_BASE <= read_weight_base_addr;
		N_R_BASE <= read_neuro_base_addr;
		N_W_BASE <= write_neuro_base_addr;
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
	if(reset || read) begin
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
