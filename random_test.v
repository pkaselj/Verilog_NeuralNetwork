`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:47:51 05/25/2022
// Design Name:   NeuralAccelerator
// Module Name:   E:/Verilog_NeuralNetwork-master/PDS_NN/random_test.v
// Project Name:  PDS_NN
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: NeuralAccelerator
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module random_test;

	// Inputs
	reg clk;
	reg in, out;


	initial begin
		// Initialize Inputs
		clk = 0;
		in = 0;
		
		#10; in = 1;
		#10; in = 0;
		
		

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
		
	always @(posedge clk) out <= in;
	
	always #1 clk = ~clk;
	
endmodule

