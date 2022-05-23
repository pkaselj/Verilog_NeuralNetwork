`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    07:10:57 05/23/2022 
// Design Name: 
// Module Name:    SI_ADD_Nbit 
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
module SI_ADD
#(parameter N = 8)
(
	input [N-1 : 0] A,
	input [N-1 : 0] B,
	output reg [N-1 : 0] A_ADD_B
);

always @(*)
	A_ADD_B = A + B;


endmodule
