`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:23:23 05/25/2022 
// Design Name: 
// Module Name:    UART 
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
module UART(
input rx, clk, reset_ext,
output tx
);

wire [7:0] data_in;
reg [7:0] data_out;
reg en_rx, en_tx;
wire done_rx, done_tx;


wire reset;
wire finished;
wire [7:0] result_base_address;
wire [7:0] result_word_count;
reg [7:0] result_base_address_reg;
reg [7:0] result_word_count_reg;
wire [7:0] data_out_nn_acceler;

wire [7:0] data;

assign reset = reset_ext;

UART_TX uart_tx_module (
		.clk(clk), 
		.enable(en_tx),
		.data_in(data_out),
		.tx(tx),
		.done(done_tx)
); 
	
UART_RX uart_rx_module (
		.clk(clk), 
		.rx(rx), 
		.enable(en_rx), 
		.data_out(data_in), 
		.done(done_rx)
);

NeuralAccelerator Accelerator(
	.clk(clk),
	.reset(reset),
	.finished(finished),
	.result_base_address(result_base_address),
	.result_word_count(result_word_count),
	.current_data(data),
	.data_out(data_out_nn_acceler)
);


initial begin
	en_rx = 1;
	en_tx = 0;
end


//always @(posedge clk) begin
//	if(finished) begin
//		data_out <= result_word_count;
//		en_tx <= 1;
//	end
//	else
//		en_tx <= 0;
//end

always @(posedge clk) begin
	if(!reset && !en_tx) begin
		if(finished) begin
			data_out <= data_out_nn_acceler;
			en_tx <= 1;
		end
	end
	else
		en_tx <= 0;
end


endmodule
