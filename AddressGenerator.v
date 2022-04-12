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
input clk, reset,
output reg [7:0] weight_read_addr, neuro_read_addr, neuro_write_addr
);

localparam
	W_R_BASE = 8'h00,
	N_R_BASE = 8'h00,
	N_W_BASE = 8'h10;

reg [1:0] neuro_prescaler;

initial begin
	weight_read_addr = W_R_BASE;
	neuro_read_addr = N_R_BASE;
	neuro_write_addr = N_W_BASE;
	neuro_prescaler = 0;
end

always @(posedge clk) begin
	if(reset) weight_read_addr <= W_R_BASE;
	else		 weight_read_addr <= (weight_read_addr == 3) ? W_R_BASE 	: 	weight_read_addr + 1	;
end

always @(posedge clk) begin
	if(reset) neuro_read_addr <= N_R_BASE;
	else		 neuro_read_addr <= (neuro_prescaler == 3) ? neuro_read_addr + 1 : neuro_read_addr;
end

always @(posedge clk) begin
	if(reset) neuro_write_addr <= N_W_BASE;
	else		 neuro_write_addr <= (neuro_prescaler == 3) ? neuro_write_addr + 1 : neuro_write_addr;
end

always @(posedge clk) begin
	if(reset) neuro_prescaler <= 0;
	else		 neuro_prescaler <= neuro_prescaler + 1;
end

endmodule
