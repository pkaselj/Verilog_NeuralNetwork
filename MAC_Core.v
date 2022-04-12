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
	input oe, reset, clk,
	output [7:0] out
);

reg [7:0] accumulator, internal_weight, internal_value;
wire [7:0] accumulator_next;

initial begin
	accumulator = 0;
	internal_weight = 0;
	internal_value = 0;
end

always @(posedge clk) begin

	if(reset) begin
		accumulator <= 0;
		internal_weight <= 0;
		internal_value <= 0;
	end else begin
		accumulator <= accumulator_next;
		internal_weight <= weight;
		internal_value <= in;
	end

end

assign accumulator_next = accumulator + internal_weight * internal_value;
assign out = (oe && !reset) ? accumulator : 8'bzzzzzzzz;

endmodule
