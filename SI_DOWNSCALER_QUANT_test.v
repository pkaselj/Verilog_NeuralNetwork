`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:43:45 05/23/2022
// Design Name:   SI_DOWNSCALER_QUANT
// Module Name:   /home/ise/Desktop/NerualNetwork/SI_DOWNSCALER_QUANT_test.v
// Project Name:  NerualNetwork
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: SI_DOWNSCALER_QUANT
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module SI_DOWNSCALER_QUANT_test;

	// Inputs
	reg [31:0] in;

	// Outputs
	wire [7:0] out;

	// Instantiate the Unit Under Test (UUT)
	SI_DOWNSCALER_QUANT
	#(
		.N_IN(32),
		.N_OUT(8),
		.M0_0Q32(1932735283),
		.SHIFT(10)
	)
	uut (
		.in(in), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		in = 0;
		
		#10 in = 316109;
		#10 in = -316109;
		#10 in = 200000;
		#10 in = -71672;
		#10 $stop;
        
		// Add stimulus here

	end
      
endmodule

