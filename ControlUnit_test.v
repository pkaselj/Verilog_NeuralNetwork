`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   09:55:48 04/12/2022
// Design Name:   ControlUnit
// Module Name:   /home/ise/Desktop/NerualNetwork/ControlUnit_test.v
// Project Name:  NerualNetwork
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ControlUnit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ControlUnit_test;

	// Inputs
	reg clk;
	reg reset;
	reg forget;

	// Outputs
	wire AG_rst;
	wire AG_read;
	wire ALU_rst;
	wire ALU_forget;

	// Instantiate the Unit Under Test (UUT)
	ControlUnit uut (
		.clk(clk),
		.forget(forget),
		.reset(reset), 
		.AG_rst(AG_rst), 
		.AG_read(AG_read), 
		.ALU_rst(ALU_rst),
		.ALU_forget(ALU_forget)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		forget = 0;
		
		#5 reset = 0;

		// Wait 100 ns for global reset to finish
		#50 reset = 1;
		#5	 reset = 0;
		#50 $stop;
        
		// Add stimulus here

	end
	
	always #2 clk = ~clk;
      
endmodule

