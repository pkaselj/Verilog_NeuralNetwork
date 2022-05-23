`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:03:16 04/12/2022 
// Design Name: 
// Module Name:    MAC_Core 
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
module MAC_Core
#(
parameter N = 8,
parameter N_ACC = 32
)(
	input [N - 1:0] weight, in,
	input oe, reset, clk, forget,
	output [N - 1:0] out
);

wire [N_ACC - 1:0] weight_upscaled,
						 value_upscaled;
						 
SI_UPSCALER
#(
	.N_IN(N),
	.N_OUT(N_ACC)
)
up1 (
	.in(weight),
	.out(weight_upscaled)
);


SI_UPSCALER
#(
	.N_IN(N),
	.N_OUT(N_ACC)
)
up2
(
	.in(in),
	.out(value_upscaled)
);

reg [N_ACC - 1:0] accumulator;
reg [N_ACC - 1:0]	internal_weight,
						internal_value;
					
wire [N_ACC - 1:0] accumulator_next,
					accumulator_state,
					result;

reg reset_1;
wire buffered_reset = reset || reset_1;

wire [N_ACC - 1:0] weight_mpy_value;


SI_MPY #(N_ACC) multiplicator (
	.A(internal_weight),
	.B(internal_value),
	.A_MPY_B(weight_mpy_value)
);

SI_ADD #(N_ACC) adder (
	.A(accumulator_state),
	.B(weight_mpy_value),
	.A_ADD_B(accumulator_next)
);

assign accumulator_state = (buffered_reset || forget) ? {N_ACC{1'b0}} : accumulator;
//assign out = (oe && !reset) ? accumulator : 8'bzzzzzzzz;
assign result = (oe && !reset) ? accumulator : 0;

wire [N - 1:0] result_downscaled;


// M0 and SHIFT used to dequantize NN output
// M = M0 * 2 ** (-SHIFT)
SI_DOWNSCALER_QUANT
#(
	.N_IN(N_ACC),
	.N_OUT(N),
	.M0_0Q32(1932735283), // 0.45 (0Q32)
	.SHIFT(10)
)
downscaler
(
	.in(result),
	.out(result_downscaled)
);


// DEBUG

assign out = result_downscaled;

//ReLU #(N) relu (
//	.in(result_downscaled),
//	.out(out)
//);

always @(posedge clk) reset_1 <= reset;

initial begin
	accumulator = 0;
	internal_weight = 0;
	internal_value = 0;
end

always @(posedge clk) begin
	if(reset) begin
		internal_weight <= 0;
		internal_value <= 0;
	end else begin
		internal_weight <= weight_upscaled;
		internal_value <= value_upscaled;
	end
end

always @(posedge clk) begin
	if(reset)
		accumulator <= 0;
	else
		accumulator <= accumulator_next;
end



endmodule
