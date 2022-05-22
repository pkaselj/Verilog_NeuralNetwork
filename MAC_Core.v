`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:03:16 04/12/2022 
// Design Name: 
// Module Name:    MAC_Core 
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
module MAC_Core(
	input [7:0] weight, in,
	input oe, reset, clk, forget,
	output [7:0] out
);

reg [7:0] accumulator;
reg [7:0] internal_weight;
reg [7:0] internal_value;
wire [7:0] accumulator_next;
wire	[7:0] accumulator_state;

reg reset_1;
wire buffered_reset = reset || reset_1;

assign accumulator_state = (buffered_reset || forget) ? 8'b0000000 : accumulator;
assign accumulator_next = accumulator_state + internal_weight * internal_value;
assign out = (oe && !reset) ? accumulator : 8'bzzzzzzzz;

always @(posedge clk) reset_1 <= reset;

initial begin
	accumulator = 0;
	internal_weight = 0;
	internal_value = 0;
end

always @(posedge clk) begin
	if(reset) begin
		internal_weight <= 0;
		internal_value <= 0;
	end else begin
		internal_weight <= weight;
		internal_value <= in;
	end
end

always @(posedge clk) begin
	if(reset)
		accumulator <= 0;
	else
		accumulator <= accumulator_next;
end



endmodule
