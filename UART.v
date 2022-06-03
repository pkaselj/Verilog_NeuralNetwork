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
output tx
);

wire [7:0] data_wire, new_data;
reg en_rx, en_tx;
wire done_rx, done_tx;
UART_TX uart_tx_module (
		.clk(clk), 
		.enable(en_tx),
		.data_in(new_data),
		.tx(tx),
		.done(done_tx)
); 
	
UART_RX uart_rx_module (
		.clk(clk), 
		.rx(rx), 
		.enable(en_rx), 
		.data_out(data_wire), 
		.done(done_rx)
);

assign new_data = data_wire;

initial begin
	en_rx = 1;
	en_tx = 0;
end

always@(posedge clk) begin
	if(done_rx) begin
		en_tx <= 1;
	end
	else begin
		en_tx <= 0;
	end
end

endmodule
