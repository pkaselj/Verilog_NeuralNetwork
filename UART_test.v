`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:56:01 06/08/2022
// Design Name:   UART
// Module Name:   C:/Users/Student/Desktop/jn/plsradi_jr/UART_test.v
// Project Name:  plsradi_jr
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: UART
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module UART_test;

	// Inputs
	reg rx;
	reg clk;

	// Outputs
	wire tx;

	// Instantiate the Unit Under Test (UUT)
	UART uut (
		.rx(rx), 
		.clk(clk), 
		.tx(tx)
	);

	initial begin
		// Initialize Inputs
		rx = 1;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		//4
		#8 rx = 0;
		#8 rx = 0;
		#8 rx = 0;
		#8 rx = 1;
		#8 rx = 0;
		#8 rx = 0;
		#8 rx = 0;
		#8 rx = 0;
		#8 rx = 0;
		#8 rx = 1;
		
		//7
		#8 rx = 0;
		#8 rx = 1;
		#8 rx = 1;
		#8 rx = 1;
		#8 rx = 0;
		#8 rx = 0;
		#8 rx = 0;
		#8 rx = 0;
		#8 rx = 0;
		#8 rx = 1;
		
		//2
		#8 rx = 0;
		#8 rx = 0;
		#8 rx = 1;
		#8 rx = 0;
		#8 rx = 0;
		#8 rx = 0;
		#8 rx = 0;
		#8 rx = 0;
		#8 rx = 0;
		#8 rx = 1;
		
		//3
		#8 rx = 0;
		#8 rx = 1;
		#8 rx = 1;
		#8 rx = 0;
		#8 rx = 0;
		#8 rx = 0;
		#8 rx = 0;
		#8 rx = 0;
		#8 rx = 0;
		#8 rx = 1;
		
		
		//14
		#8 rx = 0;
		#8 rx = 0;
		#8 rx = 1;
		#8 rx = 1;
		#8 rx = 1;
		#8 rx = 0;
		#8 rx = 0;
		#8 rx = 0;
		#8 rx = 0;
		#8 rx = 1;
		
		//27
		#8 rx = 0;
		#8 rx = 1;
		#8 rx = 1;
		#8 rx = 0;
		#8 rx = 1;
		#8 rx = 1;
		#8 rx = 0;
		#8 rx = 0;
		#8 rx = 0;
		#8 rx = 1;
		
		//99
		#8 rx = 0;
		#8 rx = 1;
		#8 rx = 1;
		#8 rx = 0;
		#8 rx = 0;
		#8 rx = 0;
		#8 rx = 1;
		#8 rx = 1;
		#8 rx = 0;
		#8 rx = 1;
		
		//123
		#8 rx = 0;
		#8 rx = 1;
		#8 rx = 1;
		#8 rx = 0;
		#8 rx = 1;
		#8 rx = 1;
		#8 rx = 1;
		#8 rx = 1;
		#8 rx = 0;
		#8 rx = 1;
		
		//1
		#8 rx = 0;
		#8 rx = 1;
		#8 rx = 0;
		#8 rx = 0;
		#8 rx = 0;
		#8 rx = 0;
		#8 rx = 0;
		#8 rx = 0;
		#8 rx = 0;
		#8 rx = 1;
		
	end
   
	
	always begin
		#1 clk = ~clk;
	end
endmodule

