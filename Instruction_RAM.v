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

reg [7:0] mem [127:0];

assign data = enable ? mem[address] : 8'bzzzzzzzz;

initial begin
	mem[0] = 4;
	mem[1] = 3;
	mem[2] = 8;
	mem[3] = 5;
	mem[4] = END_OF_PROGRAM;
end

endmodule
