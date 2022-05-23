`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   07:24:13 05/23/2022
// Design Name:   SI_MPY
// Module Name:   /home/ise/Desktop/NerualNetwork/SI_MPY_test.v
// Project Name:  NerualNetwork
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: SI_MPY
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module SI_MPY_test;

	// Inputs
	reg [7:0] A;
	reg [7:0] B;

	// Outputs
	wire [7:0] A_MPY_B;

	// Instantiate the Unit Under Test (UUT)
	SI_MPY uut (
		.A(A), 
		.B(B), 
		.A_MPY_B(A_MPY_B)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;

		#10 A = 3; B = 5;
		#10 A = 4; B = 2;
		#10 A = 13; B = -1;
		#10 A = -2; B = 4;
		#10 A = -5; B = -2;
		#10 A = 6; B = -2;
		#10 A = 10; B = 21;
		#10 A = -10; B = 21;
		#10 $stop;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

