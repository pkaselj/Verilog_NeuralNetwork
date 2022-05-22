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
				weight_read_base,
				instruction_pointer;
				
wire forget;

wire [7:0] Nk;
wire finished, neuron_finished;
wire [7:0] next_ip;

reg finished_1, finished_2;
reg neuron_finished_1, neuron_finished_2;

wire AG_rst, AG_read, ALU_rst;

// assign forget = neuro_write_address == neuro_write_base;
// assign forget = neuron_finished_2 | ALU_forget;
assign forget = neuron_finished_2;

assign next_ip = (reset) ? 0 : (finished | AG_read) ? instruction_pointer + 1 : instruction_pointer;

initial begin
	neuro_read_base = 0;
	neuro_write_base = 0;
	weight_read_base = 0;
	instruction_pointer = 0;
	finished_1 = 0;
	finished_2 = 0;
end

always @(posedge clk) begin
	if(finished) begin
		neuro_read_base <= neuro_read_address;
		neuro_write_base <= neuro_write_address;
		weight_read_base <= weight_read_address;
	end
end

always @(posedge clk) instruction_pointer <= next_ip;


always @(posedge clk) begin
	finished_1 <= finished;
	finished_2 <= finished_1;
end


always @(posedge clk) begin
	neuron_finished_1 <= neuron_finished;
	neuron_finished_2 <= neuron_finished_1;
end



ControlUnit CU(
	.clk(clk),
	.reset(reset),
	.forget(finished),
	.AG_rst(AG_rst),
	.AG_read(AG_read),
	.ALU_rst(ALU_rst)
);

Instruction_RAM Instruction_RAM_instance(
	.address(instruction_pointer),
	.data(Nk),
	.enable(1'b1)
);

AddressGenerator AddressGenerator_instance(
	.clk(clk),
	.reset(AG_rst),
	.read(AG_read),
	.Nk(Nk),
	.neuron_finished(neuron_finished),
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
	.reset(ALU_rst),
	.clk(clk),
	.forget(forget),
	.out(out)
);

endmodule
