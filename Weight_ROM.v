`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:22:13 04/12/2022 
// Design Name: 
// Module Name:    Weight_ROM 
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
module Weight_ROM
#(parameter DATA_BUS_WIDTH = 8,
parameter ADDRESS_BUS_WIDTH = 16)
(
	input [ADDRESS_BUS_WIDTH - 1:0] address,
	input enable,
	output [DATA_BUS_WIDTH - 1:0] data
);

localparam MEM_LOCATIONS = 2 ** ADDRESS_BUS_WIDTH;
reg [DATA_BUS_WIDTH - 1:0] mem [0:MEM_LOCATIONS - 1];

initial begin
	$readmemb("weights.txt", mem);
end


assign data = enable ? mem[address] : {DATA_BUS_WIDTH{1'bz}};
// DEBUG
//assign data = enable ? mem[{5'b0, address[2:0]}] : 8'bzzzzzzzz;

endmodule
