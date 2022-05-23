`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   02:52:01 04/12/2022
// Design Name:   Neuron_DP_RAM
// Module Name:   /home/ise/Desktop/NerualNetwork/Neuron_DP_RAM_test.v
// Project Name:  NerualNetwork
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Neuron_DP_RAM
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Neuron_DP_RAM_test;

	// Inputs
	reg [7:0] read_address;
	reg [7:0] write_address;
	reg [7:0] write_data;
	reg oe;
	reg wre;
	reg clk;

	// Outputs
	wire [7:0] read_data;

	// Instantiate the Unit Under Test (UUT)
	Neuron_DP_RAM uut (
		.read_address(read_address), 
		.write_address(write_address), 
		.write_data(write_data), 
		.oe(oe), 
		.wre(wre),
		.clk(clk),
		.read_data(read_data)
	);

	initial begin
		// Initialize Inputs
		read_address = 0;
		write_address = 0;
		write_data = 0;
		oe = 0;
		wre = 0;
		clk = 0;
		
		#5 read_address = 0; oe = 1;
		#5 read_address = 2;
		#5 write_address = 2; write_data = 3;
		#10 wre = 1;
		#5 wre = 0; oe = 0;
		#5 $stop;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always #2 clk = ~clk;
      
endmodule

