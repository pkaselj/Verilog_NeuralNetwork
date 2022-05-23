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
	output[N-1 : 0] A_MPY_B
);

wire sgnA, sgnB;
wire [N-2 : 0] unsignedA, unsignedB;
wire sgnResult;
wire [N-2 : 0] unsignedResult;

assign {sgnA, unsignedA} = A;
assign {sgnB, unsignedB} = B;

assign sgnResult = sgnA ^ sgnB;
assign unsignedResult = unsignedA * unsignedB;

assign A_MPY_B = {sgnResult, unsignedResult};

endmodule
