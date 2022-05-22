`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:49:11 04/12/2022 
// Design Name: 
// Module Name:    Neuron_DP_RAM 
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
module Neuron_DP_RAM(
	input [7:0] read_address, write_address, write_data,
	input oe, wre, clk,
	output [7:0] read_data
);

reg [7:0] mem [127:0];

initial begin
	mem[0] = 10;
	mem[1] = 11;
	mem[2] = 10;
	mem[3] = 11;
	mem[4] = 4;
	mem[5] = 5;
	mem[6] = 3;
	mem[7] = 2;
end

assign read_data = oe ? mem[read_address] : 8'bzzzzzzzz;

always @(posedge clk) begin
	if(wre)
		mem[write_address] <= write_data;
end


endmodule
