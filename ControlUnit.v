`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:41:52 04/12/2022 
// Design Name: 
// Module Name:    ControlUnit 
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
module ControlUnit(
input clk, reset, forget,
output AG_rst, AG_read, ALU_rst
);

parameter
	STATE_RESET_0 = 0,
	STATE_RESET_1 = 1,
	STATE_RESET_2 = 2,
	STATE_CALCULATE = 3;
	
parameter
	EVENT_CLK = 0,
	EVENT_RESET = 1,
	EVENT_FORGET = 2;
	
parameter
	OUT_DEFAULT = 4'b1011,
	OUT_AG_RST = 4'b1000,
	OUT_AG_READ = 4'b0100,
	OUT_ALU_RST = 4'b0010,
	OUT_ALU_FORGET = 4'b0001;

reg [7:0] state, next_state;
reg [3:0] out, next_out;

assign {AG_rst, AG_read, ALU_rst, ALU_forget} = out;

initial begin
	state = STATE_RESET_0;
	out = 3'b111;
end

always @(posedge clk) begin
	state <= next_state;
	out <= next_out;
end

always @(*) begin
	case(state)
		STATE_RESET_0: next_state = (reset) ? STATE_RESET_0 : STATE_RESET_1;
		STATE_RESET_1: next_state = (reset) ? STATE_RESET_0 : STATE_RESET_2;
		STATE_RESET_2: next_state = (reset) ? STATE_RESET_0 : STATE_CALCULATE;
		STATE_CALCULATE: next_state = (reset)  ? STATE_RESET_0 :
												(forget) ? STATE_RESET_2 : STATE_CALCULATE;
		default: next_state = STATE_RESET_0;
	endcase
end

always @(*) begin
	case(state)
		STATE_RESET_0: next_out = (reset) ? OUT_DEFAULT : (OUT_AG_READ | OUT_ALU_RST);
		STATE_RESET_1: next_out = (reset) ? OUT_DEFAULT : (OUT_AG_READ | OUT_ALU_RST);
		STATE_RESET_2: next_out = (reset) ? OUT_DEFAULT : 0;
		STATE_CALCULATE: next_out = (reset)  ? OUT_DEFAULT : 0;
		default: next_out = OUT_DEFAULT;
	endcase
end

endmodule
