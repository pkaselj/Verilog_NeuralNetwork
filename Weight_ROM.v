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
module Weight_ROM(
	input [7:0] address,
	input enable,
	output [7:0] data
);

reg [7:0] mem [0:255];

initial begin
	$readmemh("weights.txt", mem);
end

//initial begin
//	mem[0] = 1;
//	mem[1] = 3;
//	mem[2] = 5;
//	mem[3] = 7;
//	mem[4] = 6;
//	mem[5] = 2;
//	mem[6] = 3;
//	mem[7] = 4;
//	mem[8] = 0;
//	mem[9] = 2;
//	mem[10] = 5;
//	mem[11] = 6;
//	mem[12] = 4;
//	mem[13] = 2;
//	mem[14] = 1;
//	mem[15] = 3;
//	mem[16] = 7;
//	mem[17] = 4;
//	mem[18] = 6;
//	mem[19] = 8;
//	mem[20] = 3;
//	mem[21] = 2;
//	mem[22] = 1;
//	mem[23] = 1;
//	mem[24] = 5;
//	mem[25] = 4;
//	mem[26] = 4;
//	mem[27] = 1;
//	mem[28] = 1;
//	mem[29] = 3;
//	mem[30] = 2;
//	mem[31] = 4;
//	mem[32] = 6;
//	mem[33] = 5;
//	mem[34] = 4;
//	mem[35] = 4;
//	mem[36] = 2;
//	mem[37] = 1;
//	mem[38] = 3;
//	mem[39] = 1;
//	mem[40] = 1;
//	mem[41] = 5;
//	mem[42] = 8;
//	mem[43] = 2;
//	mem[44] = 3;
//	mem[45] = 3;
//	mem[46] = 2;
//	mem[47] = 3;
//	mem[48] = 5;
//	mem[49] = 3;
//	mem[50] = 6;
//	mem[51] = 4;
//	mem[52] = 1;
//	mem[53] = 6;
//	mem[54] = 4;
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

assign data = enable ? mem[address] : 8'bzzzzzzzz;
// DEBUG
//assign data = enable ? mem[{5'b0, address[2:0]}] : 8'bzzzzzzzz;

endmodule
