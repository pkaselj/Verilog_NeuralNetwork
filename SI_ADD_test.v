`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   07:16:00 05/23/2022
// Design Name:   SI_ADD
// Module Name:   /home/ise/Desktop/NerualNetwork/SI_ADD_test.v
// Project Name:  NerualNetwork
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: SI_ADD
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module SI_ADD_test;

	// Inputs
	reg [7:0] A;
	reg [7:0] B;

	// Outputs
	wire [7:0] A_ADD_B;

	// Instantiate the Unit Under Test (UUT)
	SI_ADD uut (
		.A(A), 
		.B(B), 
		.A_ADD_B(A_ADD_B)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;
		
		#10 A = 3; B = 5;
		#10 A = 4; B = 2;
		#10 A = 125; B = 10;
		#10 A = 13; B = -1;
		#10 A = -1; B = 4;
		#10 A = -1; B = -2;
		#10 A = 1; B = -2;
		#10 $stop;
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

