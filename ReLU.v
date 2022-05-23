`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    07:39:04 05/23/2022 
// Design Name: 
// Module Name:    ReLU 
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
module ReLU
#(parameter N = 8)
(
	input [N-1 : 0] in,
	output reg [N-1 : 0] out
);

wire sgn_in;

assign sgn_in = in[N-1];

always @(*)
	if(sgn_in == 0)
		out = in;
	else
		out = 0;

endmodule
