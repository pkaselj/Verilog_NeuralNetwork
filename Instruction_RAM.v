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
module Instruction_RAM
#(parameter DATA_BUS_WIDTH = 16,
parameter ADDRESS_BUS_WIDTH = 8)
(
	input [ADDRESS_BUS_WIDTH - 1:0] address,
	input enable,
	output [DATA_BUS_WIDTH - 1:0] data
);

localparam [DATA_BUS_WIDTH - 1:0] END_OF_PROGRAM = {DATA_BUS_WIDTH{1'b1}};
localparam MEM_LOCATIONS = 2 ** ADDRESS_BUS_WIDTH;

reg [DATA_BUS_WIDTH - 1:0] mem [0:MEM_LOCATIONS - 1];

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

assign data = enable ? mem[address] : {DATA_BUS_WIDTH{1'bz}};

endmodule
