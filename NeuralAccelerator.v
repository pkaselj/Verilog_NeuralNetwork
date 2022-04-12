`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:39:51 04/12/2022 
// Design Name: 
// Module Name:    NeuralAccelerator 
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
module NeuralAccelerator(
	input clk,
	input reset,
	output [7:0] out
);

wire [7:0] 	neuro_write_address,
				neuro_read_address,
				weight_read_address,
				weight,
				value;
				
wire forget;
reg [1:0] ctr;
				
reg rst_buf;

initial begin
	rst_buf = 0;
	ctr = 2'b11;
end
	
always @(posedge clk) begin
	if(reset)
		ctr <= 2'b11;
	else
		ctr <= ctr + 1;
end

assign forget = ctr == 0;

always @(negedge clk)
	rst_buf <= reset;

AddressGenerator AddressGenerator_instance(
	.clk(clk),
	.reset(rst_buf | reset),
	.neuro_write_addr(neuro_write_address),
	.neuro_read_addr(neuro_read_address),
	.weight_read_addr(weight_read_address)
);

Weight_ROM Weight_ROM_instance(
	.address(weight_read_address),
	.data(weight),
	.enable(1'b1)
);

Neuron_DP_RAM Neuron_DP_RAM_instance(
	.read_address(neuro_read_address), 
	.write_address(neuro_write_address), 
	.write_data(out), 
	.oe(1'b1), 
	.wre(1'b1),
	.clk(clk),
	.read_data(value)
);

MAC_Core ALU (
	.weight(weight),
	.in(value),
	.oe(1'b1),
	.reset(reset),
	.clk(clk),
	.forget(forget),
	.out(out)
);

endmodule
