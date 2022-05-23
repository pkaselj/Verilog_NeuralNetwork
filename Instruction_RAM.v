`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:49:00 04/12/2022 
// Design Name: 
// Module Name:    Instruction_RAM 
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
module Instruction_RAM(
	input [7:0] address,
	input enable,
	output [7:0] data
);

parameter [7:0] 	END_OF_PROGRAM = 8'b1111_1111;

reg [7:0] mem [0:255];

initial begin
	$readmemh("instructions.txt", mem);
end

//initial begin
//	mem[0] = 8;
//	mem[1] = 5;
//	mem[2] = 3;
//	mem[3] = END_OF_PROGRAM;
//	mem[4] = END_OF_PROGRAM;
//end

assign data = enable ? mem[address] : 8'bzzzzzzzz;

endmodule
