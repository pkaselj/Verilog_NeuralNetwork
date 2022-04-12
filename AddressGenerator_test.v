`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   03:39:07 04/12/2022
// Design Name:   AddressGenerator
// Module Name:   /home/ise/Desktop/NerualNetwork/AddressGenerator_test.v
// Project Name:  NerualNetwork
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: AddressGenerator
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module AddressGenerator_test;

	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire [7:0] weight_read_addr;
	wire [7:0] neuro_read_addr;
	wire [7:0] neuro_write_addr;

	// Instantiate the Unit Under Test (UUT)
	AddressGenerator uut (
		.clk(clk),
		.reset(reset),
		.weight_read_addr(weight_read_addr), 
		.neuro_read_addr(neuro_read_addr), 
		.neuro_write_addr(neuro_write_addr)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		
		#40 reset = 1;
		#10 reset = 0;
		
		#20 $stop;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always #2 clk = ~clk;
      
endmodule

