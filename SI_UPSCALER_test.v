`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:54:01 05/23/2022
// Design Name:   SI_UPSCALER
// Module Name:   /home/ise/Desktop/NerualNetwork/SI_UPSCALER_test.v
// Project Name:  NerualNetwork
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: SI_UPSCALER
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module SI_UPSCALER_test;

	// Inputs
	reg [7:0] in;

	// Outputs
	wire [15:0] out;

	// Instantiate the Unit Under Test (UUT)
	SI_UPSCALER
	#(
		.N_IN(8),
		.N_OUT(16)
	)
	uut (
		.in(in), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		in = 0;
		#10 in = 1;
		#10 in = 2;
		#10 in = 3;
		#10 in = 7;
		#10 in = -1;
		#10 in = -2;
		#10 in = -3;
		#10 in = -7;
		#10 in = -8;
		#10 $stop;
        
		// Add stimulus here

	end
      
endmodule

