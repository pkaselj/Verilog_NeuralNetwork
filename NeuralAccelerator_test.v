`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:55:28 04/12/2022
// Design Name:   NeuralAccelerator
// Module Name:   /home/ise/Desktop/NerualNetwork/NeuralAccelerator_test.v
// Project Name:  NerualNetwork
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

module NeuralAccelerator_test;

	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire [7:0] result_base_address, result_word_count;

	// Instantiate the Unit Under Test (UUT)
	NeuralAccelerator uut (
		.clk(clk), 
		.reset(reset), 
		.result_base_address(result_base_address),
		.result_word_count(result_word_count)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		
		#5; reset = 0;
		
		#500 $stop;
        
		// Add stimulus here

	end
      
	always begin
		#2 clk = ~clk;
	end
endmodule

