`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:19:35 05/22/2022
// Design Name:   UART_TX
// Module Name:   C:/Xilinx/UART/UART_TX_test.v
// Project Name:  UART
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: UART_TX
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module UART_TX_test;

	// Inputs
	reg clk;
	reg enable;
	reg [7:0] data_in;

	wire tx;
	wire done; 

	// Instantiate the Unit Under Test (UUT)
	UART_TX uut (
		.clk(clk), 
		.enable(enable),
		.data_in(data_in),
		.tx(tx),
		.done(done)
	); 

	initial begin
		// Initialize Inputs
		clk = 0; 
		enable = 0;
		data_in <= 8'b10101010;
		#10 enable = 1;
		#10 enable = 0;
		// Wait 100 ns for global reset to finish
		#100; 
        
		// Add stimulus here
		#1000 $stop;
	end
   
	always begin
		#1 clk <= ~clk;
	end
	
endmodule

