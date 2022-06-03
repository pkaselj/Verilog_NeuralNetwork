`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:48:05 05/25/2022
// Design Name:   UART
// Module Name:   C:/Users/Student/Desktop/Verilog_NeuralNetwork-master/NeRadi-master/UART_test.v
// Project Name:  NeRadi-master
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
		clk = 0;
		rx = 1;

		// Wait 100 ns for global reset to finish
		#100;
      	
		// Add stimulus here
		 
		#10416 rx <= 0; //start
		#10416 rx <= 0; 
		#10416 rx <= 1;
		#10416 rx <= 0;
		#10416 rx <= 1;
		#10416 rx <= 0;
		#10416 rx <= 1;
		#10416 rx <= 0;
		#10416 rx <= 1;
		#10416 rx <= 1; //stop 
		
		
		#1000000 $stop;

	end
   always begin
		#1 clk <= ~clk;
	end
endmodule

