`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:29:54 04/12/2022
// Design Name:   Weight_ROM
// Module Name:   /home/ise/Desktop/NerualNetwork/Weights_ROM_test.v
// Project Name:  NerualNetwork
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Weight_ROM
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Weights_ROM_test;

	// Inputs
	reg [7:0] address;
	reg enable;

	// Outputs
	wire [7:0] data;

	// Instantiate the Unit Under Test (UUT)
	Weight_ROM uut (
		.address(address), 
		.data(data),
		.enable(enable)
	);

	initial begin
		// Initialize Inputs
		address = 0;
		enable = 0;
		
		#5 address = 1; #1 enable = 1;
		#5 address = 2; #1 enable = 0;
		#5 address = 3; #1 enable = 1;
		#5 address = 4; #1 enable = 0;
		#5 $stop;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

