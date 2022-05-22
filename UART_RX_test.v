`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:03:19 05/19/2022
// Design Name:   UART_RX
// Module Name:   C:/Xilinx/UART/UART_RX_test.v
// Project Name:  UART
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: UART_RX
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module UART_RX_test;

	// Inputs
	reg clk;
	reg rx;
	reg enable;

	// Outputs
	wire [7:0] data_out;
	wire [1:0] test_state;
	wire done; 
	wire test;
	// Instantiate the Unit Under Test (UUT)
	UART_RX uut (
		.clk(clk), 
		.rx(rx), 
		.enable(enable), 
		.data_out(data_out), 
		.done(done),
		.test(test),
		.test_state(test_state)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rx = 1;
		enable = 1;

		// Wait 100 ns for global reset to finish
		#100;
      	
		// Add stimulus here
		 
		#64 rx <= 0; //start
		#64 rx <= 1; 
		#64 rx <= 1;
		#64 rx <= 1;
		#64 rx <= 0;
		#64 rx <= 1;
		#64 rx <= 0;
		#64 rx <= 0;
		#64 rx <= 0;
		#64 rx <= 1; //stop 
		
		
		#1000000 $stop;
	end
   always begin
		#1 clk <= ~clk;
	end
	
	
endmodule 

