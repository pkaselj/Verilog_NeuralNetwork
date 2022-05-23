`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    07:19:52 05/23/2022 
// Design Name: 
// Module Name:    SI_MPY 
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
module SI_MPY
#(parameter N = 8)
(
	input [N-1 : 0] A,
	input [N-1 : 0] B,
	output reg [N-1 : 0] A_MPY_B
);

wire sgnA, sgnB;
reg [N-2 : 0] unsignedA, unsignedB;
wire sgnResult;
wire [N-2 : 0] unsignedResult;

assign sgnA = A[N-1];
assign sgnB = B[N-1];

always @(*)
	if(sgnA == 0)
		unsignedA = A;
	else
		unsignedA = ~(A) + 1; // 2's complement
		
always @(*)
	if(sgnB == 0)
		unsignedB = B;
	else
		unsignedB = ~(B) + 1; // 2's complement

assign sgnResult = sgnA ^ sgnB;
assign unsignedResult = unsignedA * unsignedB;

always @(*)
	if(sgnResult == 0)
		A_MPY_B = {0, unsignedResult};
	else
		A_MPY_B = ~({0, unsignedResult}) + 1; // 2's complement

endmodule
