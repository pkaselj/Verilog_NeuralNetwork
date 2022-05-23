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
module NeuralAccelerator
#(
parameter IP_DATA_BUS_WIDTH = 16,
parameter IP_ADDRESS_BUS_WIDTH = 8,
parameter NEURON_DATA_BUS_WIDTH = 8,
parameter NEURON_ADDRESS_BUS_WIDTH = 10,
parameter WEIGHTS_DATA_BUS_WIDTH = 8,
parameter WEIGHTS_ADDRESS_BUS_WIDTH = 13
)
(
	input clk,
	input reset,
	input [NEURON_ADDRESS_BUS_WIDTH - 1 :0]
						neuron_ram_write_adr_ext,
						neuron_ram_read_adr_ext,
	input [NEURON_DATA_BUS_WIDTH - 1 : 0] 
						neuron_ram_write_data_ext,
						
	input 	 		neuron_ram_wr_en_ext,
	output 			finished,
	output [NEURON_DATA_BUS_WIDTH - 1:0] neuron_ram_read_data_ext,
	output reg [NEURON_ADDRESS_BUS_WIDTH - 1:0]
						  result_base_address,
						  result_word_count
);

parameter [NEURON_ADDRESS_BUS_WIDTH - 1:0]
						NEURO_RW_BASE_LOW = 0,
						NEURO_RW_BASE_HIGH = 900;

wire [NEURON_ADDRESS_BUS_WIDTH - 1:0]
				neuro_write_address,
				neuro_read_address;
				
wire [WEIGHTS_ADDRESS_BUS_WIDTH - 1:0] weight_read_address;
				
wire [WEIGHTS_DATA_BUS_WIDTH - 1:0] weight;
wire [NEURON_DATA_BUS_WIDTH - 1:0] value;
				
//reg [7:0]   neuro_read_base,
reg [NEURON_ADDRESS_BUS_WIDTH - 1:0]  neuro_write_base;
reg [WEIGHTS_ADDRESS_BUS_WIDTH - 1:0]  weight_read_base;
reg [IP_ADDRESS_BUS_WIDTH - 1:0]  instruction_pointer;
				
wire forget;

wire hold;
assign hold = reset | finished;

wire [NEURON_DATA_BUS_WIDTH - 1:0] out;

wire [IP_DATA_BUS_WIDTH - 1 :0] Nk;
wire [IP_ADDRESS_BUS_WIDTH - 1 :0] next_ip;
		
wire finished_layer, neuron_finished;

//reg finished_layer_1 /*, finished_layer_2*/;
reg 	neuron_finished_1,
		neuron_finished_2;

reg [NEURON_ADDRESS_BUS_WIDTH - 1 :0]
		neuro_write_address_1,
		neuro_write_address_2;

wire AG_rst, AG_read, ALU_rst;

wire [IP_DATA_BUS_WIDTH - 1 :0] current_layer_size, previous_layer_size;
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

parameter [IP_DATA_BUS_WIDTH - 1 :0] 	END_OF_PROGRAM = {IP_DATA_BUS_WIDTH{1'b1}};
assign program_finished = (current_layer_size == END_OF_PROGRAM);


always @(posedge clk) begin
	if(!hold) begin
		result_base_address <= neuro_write_base;
		result_word_count <= previous_layer_size;
	end
end

// assign forget = neuro_write_address == neuro_write_base;
// assign forget = neuron_finished_2 | ALU_forget;
assign forget = neuron_finished_2;

assign next_ip = (reset) ? 0 : (finished_layer | AG_read) ? instruction_pointer + 1 : instruction_pointer;

initial begin
//	neuro_read_base = NEURO_RW_BASE_LOW;
	neuro_write_base = NEURO_RW_BASE_HIGH;
	weight_read_base = 0;
	instruction_pointer = 0;
//	finished_layer_1 = 0;
//	finished_layer_2 = 0;
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

wire [NEURON_ADDRESS_BUS_WIDTH - 1 :0]
				next_neuro_read_base_address,
				next_neuro_write_base_address;
				
wire [WEIGHTS_ADDRESS_BUS_WIDTH - 1 :0]	next_weight_read_base_address;
				
wire is_IP_even;
assign is_IP_even = (instruction_pointer[0] == 0);
				
assign next_neuro_read_base_address = 	(is_IP_even) ? NEURO_RW_BASE_HIGH : NEURO_RW_BASE_LOW;																	
assign next_neuro_write_base_address = (is_IP_even) ? NEURO_RW_BASE_LOW : NEURO_RW_BASE_HIGH;
																		
assign next_weight_read_base_address = (reset) ? 0 : (finished_layer) ? weight_read_address + 1 : weight_read_base;

always @(posedge clk) begin
//	neuro_read_base <= next_neuro_read_base_address;
	if(!hold) begin
		neuro_write_base <= next_neuro_write_base_address;
		weight_read_base <= next_weight_read_base_address;
	end
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
//	finished_layer_1 <= finished_layer;
//	finished_layer_2 <= finished_layer_1;
end


always @(posedge clk) begin
	neuron_finished_1 <= neuron_finished;
	neuron_finished_2 <= neuron_finished_1;
end

wire select_external_bus;
assign select_external_bus = reset | finished;

assign neuron_ram_read_data_ext = value;

wire [NEURON_ADDRESS_BUS_WIDTH - 1 :0] 	neuron_read_address_bus_interface,
				neuro_write_address_bus_interface;
				
wire [NEURON_DATA_BUS_WIDTH - 1:0] neuro_write_data_bus_interface;
wire 			neuro_wr_en_wire_interface;

BusArbiter
#(
	.DATA_BUS_WIDTH(NEURON_DATA_BUS_WIDTH),
	.ADDRESS_BUS_WIDTH(NEURON_ADDRESS_BUS_WIDTH)
)
Arbiter(
		.neuron_read_address_ext(neuron_ram_read_adr_ext),
		.neuron_read_address_int(neuro_read_address),
		
		.neuron_write_address_ext(neuron_ram_write_adr_ext),
		.neuron_write_address_int(neuro_write_address_2),
		
		.neuron_write_data_ext(neuron_ram_write_data_ext),
		.neuron_write_data_int(out),
		
		.neuron_write_enable_ext(neuron_ram_wr_en_ext),
		.neuron_write_enable_int(neuron_finished_2),
		
		.select_external(select_external_bus),
		
		.neuron_read_address(neuron_read_address_bus_interface),
		.neuron_write_address(neuro_write_address_bus_interface),
		.neuron_write_data(neuro_write_data_bus_interface),
		.neuron_write_enable(neuro_wr_en_wire_interface)
);

ControlUnit CU(
	.clk(clk),
	.reset(reset),
	.forget(finished_layer),
	.AG_rst(AG_rst),
	.AG_read(AG_read),
	.ALU_rst(ALU_rst)
);

Instruction_RAM
#(
	.DATA_BUS_WIDTH(IP_DATA_BUS_WIDTH),
	.ADDRESS_BUS_WIDTH(IP_ADDRESS_BUS_WIDTH)
)
Instruction_RAM_instance(
	.address(instruction_pointer),
	.data(Nk),
	.enable(1'b1)
);

AddressGenerator
#(
	.IP_DATA_BUS_WIDTH(IP_DATA_BUS_WIDTH),
	.WEIGHTS_ADDRESS_BUS_WIDTH(WEIGHTS_ADDRESS_BUS_WIDTH),
	.NEURON_ADDRESS_BUS_WIDTH(NEURON_ADDRESS_BUS_WIDTH)
)
AddressGenerator_instance(
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

Weight_ROM
#(
	.DATA_BUS_WIDTH(WEIGHTS_DATA_BUS_WIDTH),
	.ADDRESS_BUS_WIDTH(WEIGHTS_ADDRESS_BUS_WIDTH)
)
Weight_ROM_instance(
	.address(weight_read_address),
	.data(weight),
	.enable(1'b1)
);

Neuron_DP_RAM
#(
	.DATA_BUS_WIDTH(NEURON_DATA_BUS_WIDTH),
	.ADDRESS_BUS_WIDTH(NEURON_ADDRESS_BUS_WIDTH)
)
Neuron_DP_RAM_instance(
	.read_address(neuron_read_address_bus_interface), 
	.write_address(neuro_write_address_bus_interface), 
	.write_data(neuro_write_data_bus_interface), 
	.oe(1'b1), 
	.wre(neuro_wr_en_wire_interface),
	.clk(clk),
	.read_data(value)
	/* DEBUG */
	// .read_data_offset20(data_out)
);

//assign current_data = out;

MAC_Core
#(.N(NEURON_DATA_BUS_WIDTH))
ALU (
	.weight(weight),
	.in(value),
	.oe(1'b1),
	.reset(ALU_rst),
	.clk(clk),
	.forget(forget),
	.out(out)
);

endmodule
