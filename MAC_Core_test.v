`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:11:19 04/12/2022
// Design Name:   MAC_Core
// Module Name:   /home/ise/Desktop/NerualNetwork/MAC_Core_test.v
// Project Name:  NerualNetwork
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MAC_Core
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module MAC_Core_test;

	// Inputs
	reg [7:0] weight;
	reg [7:0] in;
	reg oe;
	reg reset;
	reg clk;

	// Outputs
	wire [7:0] out;

	// Instantiate the Unit Under Test (UUT)
	MAC_Core
	#(.N(8), .N_ACC(32))
	uut (
		.weight(weight), 
		.in(in), 
		.oe(oe), 
		.reset(reset), 
		.clk(clk), 
		.out(out),
		.forget(0)
	);

	initial begin
		// Initialize Inputs
		weight = 0;
		in = 0;
		reset = 0;
		oe = 0;
		clk = 0;

		#10 oe = 1;
		
		#10 reset = 1;
		
		#10 reset = 0;	weight = 2; in = 2; oe = 0;
		#10 reset = 0;	weight = 2; in = 2; oe = 0;
		#10 reset = 0;	weight = 2; in = 2; oe = 0;
		#1 oe = 1;
		
		#10 reset = 1;
		
		#10 reset = 0;	weight = 2; in = 2; oe = 0;
		#10 reset = 0;	weight = -2; in = 2; oe = 0;
		#10 reset = 0;	weight = -2; in = 2; oe = 0;
		#1  oe = 1;
		
		#10 $stop;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always begin
	#3 clk = ~clk;
	end
      
endmodule

