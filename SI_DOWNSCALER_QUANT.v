`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:07:16 05/23/2022 
// Design Name: 
// Module Name:    SI_DOWNSCALER_QUANT 
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
module SI_DOWNSCALER_QUANT
#(
	parameter N_IN = 32,
	parameter N_OUT = 8,
	parameter M0_0Q32 = 1932735283,
	parameter SHIFT = 10,
	parameter OFFSET = 22
)
(
	input [N_IN - 1: 0] in,
	output [N_OUT - 1: 0] out
);

localparam N_INTERM = 2 * N_IN;

wire [N_INTERM -1 : 0] mpy_result, in_upscaled, M0_wire;
wire [N_OUT - 1: 0] OFFSET_wire;

assign M0_wire = M0_0Q32;
assign OFFSET_wire = OFFSET;

SI_UPSCALER
#(
	.N_IN(N_IN),
	.N_OUT(N_INTERM)
)
up1
(
	.in(in),
	.out(in_upscaled)
);


SI_MPY #(N_INTERM) multiplicator (
	.A(in_upscaled),
	.B(M0_wire),
	.A_MPY_B(mpy_result)
);

localparam OVERFLOW_MASK_SI = { {(N_IN - N_OUT + 1){1'b1}} ,{(N_OUT - 1){1'b0}} };

reg [N_INTERM - 1: 0] preresult, mpy_result_unsigned_value;
wire is_input_number_negative, is_overflow;
reg is_over_0_5_frac; 

always @(*) begin
	if(is_input_number_negative)
		mpy_result_unsigned_value = ~mpy_result + 1;
	else
		mpy_result_unsigned_value = mpy_result;
end

assign is_input_number_negative = (in[N_IN - 1] == 1);

assign is_overflow = |(preresult & OVERFLOW_MASK_SI);

always @(*) begin
	preresult = mpy_result_unsigned_value >> (SHIFT + 32 - 1);
	is_over_0_5_frac = preresult[0]; // First fractional bit
	preresult = preresult >> 1;
end


localparam MAX_OUT_SI = {1'b0, {(N_OUT - 1){1'b1}} };
localparam MIN_OUT_SI = {1'b1, {(N_OUT - 1){1'b0}} };

reg [N_OUT - 1: 0] unoffset_out;
wire [N_OUT - 1: 0] offset_out;

always @(*) begin

	// Clamp to MAX or MIN if output number
	//	overflows/underflows
	if (is_overflow) begin
		unoffset_out = (is_input_number_negative) ? MIN_OUT_SI : MAX_OUT_SI;
	end else	if (is_over_0_5_frac == 1)  	// Round to neares integer
		unoffset_out = preresult[N_IN - 1:0] + 1;		// ! Used to prevent down-rounding
	else
		unoffset_out = preresult[N_IN - 1:0];
		
	if(is_input_number_negative)
		unoffset_out = ~unoffset_out + 1;
		
end

SI_ADD #(N_OUT) adder (
	.A(unoffset_out),
	.B(OFFSET_wire),
	.A_ADD_B(offset_out)
);

assign out = (is_overflow) ? unoffset_out : offset_out;

endmodule
