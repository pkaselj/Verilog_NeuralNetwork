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
	/* DEBUG */
//	output [7:0] read_data_offset20
);

reg [7:0] mem [0:127];

initial begin
	$readmemh("neuron_ram_data.bin", mem);
end

//initial begin
//	mem[0] = 10;
//	mem[1] = 11;
//	mem[2] = 5;
//	mem[3] = 2;
//	mem[4] = 4;
//	mem[5] = 5;
//	mem[6] = 3;
//	mem[7] = 2;
//	mem[8] = 0;
//	mem[9] = 0;
//	mem[10] = 0;
//	mem[11] = 0;
//	mem[12] = 0;
//	mem[13] = 0;
//	mem[14] = 0;
//	mem[15] = 0;
//	mem[16] = 0;
//	mem[17] = 0;
//	mem[18] = 0;
//	mem[19] = 0;
//	mem[20] = 0;
//	mem[21] = 0;
//	mem[22] = 0;
//	mem[23] = 0;
//	mem[24] = 0;
//	mem[25] = 0;
//	mem[26] = 0;
//	mem[27] = 0;
//	mem[28] = 0;
//	mem[29] = 0;
//	mem[30] = 0;
//	mem[31] = 0;
//	mem[32] = 0;
//	mem[33] = 0;
//	mem[34] = 0;
//	mem[35] = 0;
//	mem[36] = 0;
//	mem[37] = 0;
//	mem[38] = 0;
//	mem[39] = 0;
//end

assign read_data = oe ? (wre && (read_address == write_address)) ? write_data : mem[read_address]
								: 8'bzzzzzzzz;

always @(posedge clk) begin
	if(wre)
		mem[write_address] <= write_data;
end

assign read_data_offset20 = mem[20];

endmodule
