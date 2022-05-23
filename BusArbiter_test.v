`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   01:54:52 05/23/2022
// Design Name:   BusArbiter
// Module Name:   /home/ise/Desktop/NerualNetwork/BusArbiter_test.v
// Project Name:  NerualNetwork
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: BusArbiter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
	module BusArbiter_test;
	
	reg [7:0] 	neuron_read_address_ext = 8'hBE,
					neuron_read_address_int = 8'hEF,
					neuron_write_address_ext = 8'hBE,
					neuron_write_address_int = 8'hEF,
					neuron_write_data_ext = 8'hBE,
					neuron_write_data_int = 8'hEF;
					
	reg			neuron_write_enable_ext = 1,
					neuron_write_enable_int = 0;
					
	reg			select_external;
	
	wire [7:0] 	neuron_read_address,
					neuron_write_address,
					neuron_write_data;
					
	wire			neuron_write_enable;
	// Instantiate the Unit Under Test (UUT)
	BusArbiter uut (
		.neuron_read_address_ext(neuron_read_address_ext),
		.neuron_read_address_int(neuron_read_address_int),
		.neuron_write_address_ext(neuron_write_address_ext),
		.neuron_write_address_int(neuron_write_address_int),
		.neuron_write_data_ext(neuron_write_data_ext),
		.neuron_write_data_int(neuron_write_data_int),
		.neuron_write_enable_ext(neuron_write_enable_ext),
		.neuron_write_enable_int(neuron_write_enable_int),
		.select_external(select_external),
		.neuron_read_address(neuron_read_address),
		.neuron_write_address(neuron_write_address),
		.neuron_write_data(neuron_write_data),
		.neuron_write_enable(neuron_write_enable)
	);

	initial begin
		// Initialize Inputs
		
		select_external = 1;
		
		#10 select_external = 0;
		#10 $stop;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

