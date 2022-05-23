`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:38:42 04/12/2022 
// Design Name: 
// Module Name:    Neuron_ROM 
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
module Neuron_ROM(
	input [7:0] address,
	input enable,
	output [7:0] data
);

reg [7:0] mem [127:0];

initial begin
	mem[0] = 10;
	mem[1] = 10;
	mem[2] = 11;
	mem[3] = 11;
end

assign data = enable ? mem[address] : 8'bzzzzzzzz;

endmodule
