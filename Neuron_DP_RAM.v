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
module Neuron_DP_RAM
#(parameter DATA_BUS_WIDTH = 8,
parameter ADDRESS_BUS_WIDTH = 16)
(
	input [ADDRESS_BUS_WIDTH - 1:0] read_address, write_address,
	input [DATA_BUS_WIDTH - 1 : 0] write_data,
	input oe, wre, clk,
	output [DATA_BUS_WIDTH - 1:0] read_data
);

localparam MEM_LOCATIONS = 2 ** ADDRESS_BUS_WIDTH;

reg [DATA_BUS_WIDTH - 1:0] mem [0:MEM_LOCATIONS - 1];

initial begin
	$readmemb("neurons.txt", mem);
end

assign read_data = oe ? (wre && (read_address == write_address)) ? write_data : mem[read_address]
								: {DATA_BUS_WIDTH{1'bz}};

always @(posedge clk) begin
	if(wre)
		mem[write_address] <= write_data;
end

//assign read_data_offset20 = mem[20];

endmodule
