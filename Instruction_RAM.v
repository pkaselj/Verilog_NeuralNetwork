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

reg [7:0] mem [127:0];

assign data = enable ? mem[address] : 8'bzzzzzzzz;

initial begin
	mem[0] = 2;
	mem[1] = 2;
	mem[2] = 3;
	mem[3] = 3;
end

endmodule
