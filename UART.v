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
input rx, clk,
output tx,
output cs_clk
);

parameter image_byte_size = 784;

wire [7:0] data_in;
reg en_rx, en_tx;
wire done_rx, done_tx;


reg [15:0] abr;
always @(posedge clk)
	abr <= abr+1;
	
assign cs_clk = abr[15];

reg reset;
reg reset_from_tx, reset_from_rx;
wire finished;
wire [9:0] result_base_address;			//adresa od koje kreces citat - output
wire [9:0] result_word_count;				//broj adreasa - output		
wire [7:0] data_out_nn_acceler;
reg [9:0] neuron_ram_write_adr_ext;
//reg [7:0] neuron_ram_write_data_ext;
reg neuron_ram_wr_en_ext;
reg [9:0] image_byte_counter;
reg [3:0] read_counter = 0;
//reg tx_busy;
reg [9:0] read_result_address;
//assign reset = reset_ext;
reg neuron_ram_wr_en_ext_1;
reg en_tx_1;
reg reset_from_tx_1;
reg reset_from_rx_1;
reg reset_from_rx_2;

UART_TX uart_tx_module (
		.clk(clk), 
		.enable(en_tx),
		.data_in(data_out_nn_acceler),
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
	.neuron_ram_write_adr_ext(neuron_ram_write_adr_ext),		//input - adresa na koju pisen
	.neuron_ram_write_data_ext(data_in),	//input - podaci koje upisujen na gornju adresu
	.neuron_ram_read_adr_ext(read_result_address),				//input 	result_base_address + (0...result_word_count-1)
	.neuron_ram_wr_en_ext(neuron_ram_wr_en_ext_1),					//input - 0->1 iduci takt upisuje u memoriju
	.neuron_ram_read_data_ext(data_out_nn_acceler),				//output podaci na adresi neuron_ram_read_adr_ext
	.clk(clk),
	.reset(reset),															//1->0 kad ucitan sliku - input
	.finished(finished),													//0->1 kad je gotov - output
	.result_base_address(result_base_address),					//adresa od koje kreces citat - output
	.result_word_count(result_word_count)							//broj adreasa - output
);


initial begin 
	en_rx = 1;
	en_tx = 0;
	en_tx_1 = 0;
//	tx_busy = 0;
	image_byte_counter = 0;
	reset = 1; 
end


always@(posedge clk) begin
	neuron_ram_wr_en_ext <= 0;
	if(image_byte_counter < image_byte_size) begin
		reset_from_rx <= 0;
		if(done_rx) begin
			image_byte_counter <= image_byte_counter + 1;
			neuron_ram_write_adr_ext <= image_byte_counter;
			//neuron_ram_write_data_ext <= data_in;
			neuron_ram_wr_en_ext <= 1;
		end
	end
	else begin 
		image_byte_counter <= 0;
		reset_from_rx <= 1;
		en_rx <= 0;
		//en_tx_1 <= 1;
	end
	if(finished)
		en_rx <= 1;
end
//assign data_out_nn_acceler = data_out_nn_acceler_reg;

//assign data_out_nn_acceler = 27;


always@(posedge clk) begin
	en_tx <= en_tx_1;
	neuron_ram_wr_en_ext_1 <= neuron_ram_wr_en_ext;
	reset_from_tx_1 <= reset_from_tx;
	reset_from_rx_2 <= reset_from_rx_1;
	reset_from_rx_1 <= reset_from_rx;
end

always@(posedge clk) begin
	if(reset_from_rx_2 == 1)
		reset <= 0;
	else if(reset_from_tx_1 == 1)
		reset <= 1;
end

always@(posedge clk) begin
	if(finished) begin
		if(read_counter == 0) begin
			read_result_address <= result_base_address + read_counter;
			read_counter <= read_counter + 1;
			reset_from_tx <= 0;
			en_tx_1 <= 1;
		end
		else if(done_tx) begin //wait for tx to finish transmitting a byte
			read_counter <= read_counter + 1;
			if(read_counter < result_word_count) begin
				read_result_address <= result_base_address + read_counter;
				//data_out <= data_out_nn_acceler;
				//TODO:
				if(read_counter == result_word_count)
					en_tx_1 <= 0;
			end
			else begin
				//data_out <= data_out_nn_acceler;
				reset_from_tx <= 1;
				en_tx_1 <= 0;
			end
		end
	end
	else begin
		read_counter <= 0;
		en_tx_1 <= 0;
		reset_from_tx <= 0;
	end
end


endmodule
