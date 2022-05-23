`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:43:42 05/23/2022 
// Design Name: 
// Module Name:    BusArbiter 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module BusArbiter(
	input wire [7:0] 	neuron_read_address_ext,
							neuron_read_address_int,
							neuron_write_address_ext,
							neuron_write_address_int,
							neuron_write_data_ext,
							neuron_write_data_int,
					
	input wire			neuron_write_enable_ext,
							neuron_write_enable_int,
							
	input wire			select_external,
	
	output wire [7:0] neuron_read_address,
							neuron_write_address,
							neuron_write_data,
					
	output wire			neuron_write_enable
);

assign {
			neuron_read_address,
			neuron_write_address,
			neuron_write_data,
			neuron_write_enable
		}
			=	(select_external) ?
		{
			neuron_read_address_ext,
			neuron_write_address_ext,
			neuron_write_data_ext,
			neuron_write_enable_ext
		}
			:
		{
			neuron_read_address_int,
			neuron_write_address_int,
			neuron_write_data_int,
			neuron_write_enable_int
		};

endmodule
