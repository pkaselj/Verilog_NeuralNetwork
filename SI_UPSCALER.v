`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:47:22 05/23/2022 
// Design Name: 
// Module Name:    SI_UPSCALER 
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
module SI_UPSCALER
#(
	parameter N_IN = 8,
	parameter N_OUT = 32
)
(
	input [N_IN - 1: 0] in,
	output reg [N_OUT - 1: 0] out
);

wire in_sign;
reg [N_IN - 1: 0] in_unsigned;

assign in_sign = in[N_IN - 1];

always@(*) begin
	if(in_sign == 1) begin
		out = {N_OUT{1'b0}};
		in_unsigned = ~in + 1;
		out = out | { {(N_OUT - N_IN){1'b0}}, in_unsigned};
		out = ~out + 1;
	end else begin
		out = { {(N_OUT-N_IN){1'b0}}, in};
	end
end

endmodule
