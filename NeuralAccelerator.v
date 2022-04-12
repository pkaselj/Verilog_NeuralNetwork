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
				
reg [7:0]   neuro_read_base,
				neuro_write_base,
				weight_read_base;
				
wire forget;

wire [7:0] Nk;
				
reg rst_buf, rst_buf2;

initial begin
	rst_buf = 0;
	neuro_read_base = 0;
	neuro_write_base = 10;
	weight_read_base = 0;
end

// assign forget = neuro_write_address == neuro_write_base;
assign forget = 0;

always @(posedge clk) begin
	rst_buf <= reset;
	rst_buf2 <= rst_buf;
end

reg read, read_1, read_2;

always @(posedge clk) begin
	read_1 <= read;
	read_2 <= read_1;
	if(reset)
		read <= 1;
	else
		read <= 0;
end

wire finished;

Instruction_RAM Instruction_RAM_instance(
	.address(0),
	.data(Nk),
	.enable(1'b1)
);

AddressGenerator AddressGenerator_instance(
	.clk(clk),
	.reset(rst_buf | reset),
	.read(read | read_1 | read_2),
	.Nk(Nk),
	.read_weight_base_addr(weight_read_base),
	.read_neuro_base_addr(neuro_read_base),
	.write_neuro_base_addr(neuro_write_base),
	.finished(finished),
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
	.wre(1'b0),
	.clk(clk),
	.read_data(value)
);

MAC_Core ALU (
	.weight(weight),
	.in(value),
	.oe(1'b1),
	.reset(reset | read | read_1 | read_2),
	.clk(clk),
	.forget(forget),
	.out(out)
);

endmodule
