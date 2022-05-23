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
	output finished,
	/* ADD INPUT ADDRESS AND DATA LINES + WE */
	output [7:0] data_out,
	output [7:0] 	result_base_address,
						result_word_count,
						current_data
);

parameter [7:0] 	NEURO_RW_BASE_LOW = 0,
						NEURO_RW_BASE_HIGH = 20;

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

wire [7:0] out;

wire [7:0] Nk;
wire finished_layer, neuron_finished;
wire [7:0] next_ip;

reg finished_layer_1, finished_layer_2;
reg neuron_finished_1, neuron_finished_2;
reg [7:0] neuro_write_address_1, neuro_write_address_2;

wire AG_rst, AG_read, ALU_rst;

wire [7:0] current_layer_size, previous_layer_size;
wire program_finished;

reg finished_1, finished_2;
assign finished = finished_2;

always @(posedge clk) begin
	if(reset) begin
		finished_1 <= 0;
		finished_2 <= 0;
	end else begin
		finished_1 <= program_finished;
		finished_2 <= finished_1;
	end
end

parameter [7:0] 	END_OF_PROGRAM = 8'b1111_1111;
assign program_finished = (current_layer_size == END_OF_PROGRAM);

assign result_base_address = neuro_write_base;
assign result_word_count = previous_layer_size;


// assign forget = neuro_write_address == neuro_write_base;
// assign forget = neuron_finished_2 | ALU_forget;
assign forget = neuron_finished_2;

assign next_ip = (reset) ? 0 : (finished_layer | AG_read) ? instruction_pointer + 1 : instruction_pointer;

initial begin
	neuro_read_base = NEURO_RW_BASE_LOW;
	neuro_write_base = NEURO_RW_BASE_HIGH;
	weight_read_base = 0;
	instruction_pointer = 0;
	finished_layer_1 = 0;
	finished_layer_2 = 0;
	neuro_write_address_1 = NEURO_RW_BASE_LOW;
	neuro_write_address_2 = NEURO_RW_BASE_LOW;
	finished_1 = 0;
	finished_2 = 0;
end

always @(posedge clk) begin
	if(reset) begin
		neuro_write_address_1 <= NEURO_RW_BASE_LOW;
		neuro_write_address_2 <= NEURO_RW_BASE_LOW;
	end else begin
		neuro_write_address_1 <= neuro_write_address;
		neuro_write_address_2 <= neuro_write_address_1;
	end
end

wire [7:0] 	next_neuro_read_base_address,
				next_neuro_write_base_address,
				next_weight_read_base_address;
				
wire is_IP_even;
assign is_IP_even = (instruction_pointer[0] == 0);
				
assign next_neuro_read_base_address = 	(is_IP_even) ? NEURO_RW_BASE_HIGH : NEURO_RW_BASE_LOW;																	
assign next_neuro_write_base_address = (is_IP_even) ? NEURO_RW_BASE_LOW : NEURO_RW_BASE_HIGH;
																		
assign next_weight_read_base_address = (reset) ? 0 : (finished_layer) ? weight_read_address + 1 : weight_read_base;

always @(posedge clk) begin
	neuro_read_base <= next_neuro_read_base_address;
	neuro_write_base <= next_neuro_write_base_address;
	weight_read_base <= next_weight_read_base_address;
end

//always @(posedge clk) begin
//	if(finished_layer) begin
//		neuro_read_base <= neuro_read_address;
//		neuro_write_base <= neuro_write_address;
//		weight_read_base <= weight_read_address;
//	end
//end

always @(posedge clk) instruction_pointer <= next_ip;


always @(posedge clk) begin
	finished_layer_1 <= finished_layer;
	finished_layer_2 <= finished_layer_1;
end


always @(posedge clk) begin
	neuron_finished_1 <= neuron_finished;
	neuron_finished_2 <= neuron_finished_1;
end



ControlUnit CU(
	.clk(clk),
	.reset(reset),
	.forget(finished_layer),
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
	.read(AG_read | finished_layer),
	.Nk(Nk),
	.neuron_finished(neuron_finished),
	.read_weight_base_addr(next_weight_read_base_address),
	.read_neuro_base_addr(next_neuro_read_base_address),
	.write_neuro_base_addr(next_neuro_write_base_address),
	.finished(finished_layer),
	.neuro_write_addr(neuro_write_address),
	.neuro_read_addr(neuro_read_address),
	.weight_read_addr(weight_read_address),
	.current_layer_size(current_layer_size),
	.previous_layer_size(previous_layer_size)
);

 Weight_ROM Weight_ROM_instance(
	.address(weight_read_address),
	.data(weight),
	.enable(1)
);

 Neuron_DP_RAM Neuron_DP_RAM_instance(
	.read_address(neuro_read_address), 
	.write_address(neuro_write_address_2), 
	.write_data(out), 
	.oe(1), 
	.wre(neuron_finished_2),
	.clk(clk),
	.read_data(value),
	/* DEBUG */
	.read_data_offset20(data_out)
);

assign current_data = out;

 MAC_Core ALU (
	.weight(weight),
	.in(value),
	.oe(1),
	.reset(ALU_rst),
	.clk(clk),
	.forget(forget),
	.out(out)
);

endmodule
