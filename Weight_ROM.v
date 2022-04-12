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

reg [7:0] mem [127:0];

initial begin
	mem[0] = 1;
	mem[1] = 3;
	mem[2] = 2;
	mem[3] = 5;
	mem[4] = 6;
	mem[5] = 5;
	mem[6] = 5;
	mem[7] = 2;
	mem[8] = 1;
	mem[9] = 3;
	mem[10] = 2;
	mem[11] = 5;
	mem[12] = 6;
	mem[13] = 5;
	mem[14] = 5;
	mem[15] = 2;
	mem[16] = 1;
	mem[17] = 3;
	mem[18] = 2;
	mem[19] = 5;
	mem[20] = 6;
	mem[21] = 5;
	mem[22] = 5;
	mem[23] = 2;
	mem[24] = 1;
	mem[25] = 3;
	mem[26] = 2;
	mem[27] = 5;
	mem[28] = 6;
	mem[29] = 5;
	mem[30] = 5;
	mem[31] = 2;
end

assign data = enable ? mem[address] : 8'bzzzzzzzz;

endmodule
