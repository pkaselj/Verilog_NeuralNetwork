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
	output [7:0] read_data,
	(*S="True"*)(*KEEP="True"*) output [7:0]dbg_mem_0,
	dbg_mem_1,
	dbg_mem_2,
	dbg_mem_3
	/* DEBUG */
//	output [7:0] read_data_offset20
);

reg [7:0] mem [0:255];

assign dbg_mem_0 = mem[0];
assign dbg_mem_1 = mem[1];
assign dbg_mem_2 = mem[2];
assign dbg_mem_3 = mem[3];

initial begin
	$readmemh("neurons.txt", mem);
end

//initial begin
//	mem[0] = 7;
//	mem[1] = 2;
//	mem[2] = 3;
//	mem[3] = 1;
//	mem[4] = 4;
//	mem[5] = 8;
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
//	mem[40] = 0;
//	mem[41] = 0;
//	mem[42] = 0;
//	mem[43] = 0;
//	mem[44] = 0;
//	mem[45] = 0;
//	mem[46] = 0;
//	mem[47] = 0;
//	mem[48] = 0;
//	mem[49] = 0;
//	mem[50] = 0;
//	mem[51] = 0;
//	mem[52] = 0;
//	mem[53] = 0;
//	mem[54] = 0;
//	mem[55] = 0;
//	mem[56] = 0;
//	mem[57] = 0;
//	mem[58] = 0;
//	mem[59] = 0;
//	mem[60] = 0;
//	mem[61] = 0;
//	mem[62] = 0;
//	mem[63] = 0;
//	mem[64] = 0;
//	mem[65] = 0;
//	mem[66] = 0;
//	mem[67] = 0;
//	mem[68] = 0;
//	mem[69] = 0;
//	mem[70] = 0;
//	mem[71] = 0;
//	mem[72] = 0;
//	mem[73] = 0;
//	mem[74] = 0;
//	mem[75] = 0;
//	mem[76] = 0;
//	mem[77] = 0;
//	mem[78] = 0;
//	mem[79] = 0;
//	mem[80] = 0;
//	mem[81] = 0;
//	mem[82] = 0;
//	mem[83] = 0;
//	mem[84] = 0;
//	mem[85] = 0;
//	mem[86] = 0;
//	mem[87] = 0;
//	mem[88] = 0;
//	mem[89] = 0;
//	mem[90] = 0;
//	mem[91] = 0;
//	mem[92] = 0;
//	mem[93] = 0;
//	mem[94] = 0;
//	mem[95] = 0;
//	mem[96] = 0;
//	mem[97] = 0;
//	mem[98] = 0;
//	mem[99] = 0;
//	mem[100] = 0;
//	mem[101] = 0;
//	mem[102] = 0;
//	mem[103] = 0;
//	mem[104] = 0;
//	mem[105] = 0;
//	mem[106] = 0;
//	mem[107] = 0;
//	mem[108] = 0;
//	mem[109] = 0;
//	mem[110] = 0;
//	mem[111] = 0;
//	mem[112] = 0;
//	mem[113] = 0;
//	mem[114] = 0;
//	mem[115] = 0;
//	mem[116] = 0;
//	mem[117] = 0;
//	mem[118] = 0;
//	mem[119] = 0;
//	mem[120] = 0;
//	mem[121] = 0;
//	mem[122] = 0;
//	mem[123] = 0;
//	mem[124] = 0;
//	mem[125] = 0;
//	mem[126] = 0;
//	mem[127] = 0;
//end

assign read_data = oe ? (wre && (read_address == write_address)) ? write_data : mem[read_address]
								: 8'bzzzzzzzz;

always @(posedge clk) begin
	if(wre)
		mem[write_address] <= write_data;
end

//assign read_data_offset20 = mem[20];

endmodule
