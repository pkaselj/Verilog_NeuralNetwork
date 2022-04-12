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
input clk, reset,
output AG_rst, AG_read, ALU_rst
);

parameter
	STATE_RESET_0 = 0,
	STATE_RESET_1 = 1,
	STATE_RESET_2 = 2,
	STATE_CALCULATE = 3;
	
parameter
	EVENT_CLK = 0,
	EVENT_RESET = 1;
	
parameter
	OUT_DEFAULT = 3'b101,
	OUT_AG_RST = 3'b100,
	OUT_AG_READ = 3'b010,
	OUT_ALU_RST = 3'b001;

reg [7:0] state, next_state;
reg [2:0] out, next_out;

assign {AG_rst, AG_read, ALU_rst} = out;

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
		STATE_CALCULATE: next_state = (reset) ? STATE_RESET_0 : STATE_CALCULATE;
	endcase
end

always @(*) begin
	case(state)
		STATE_RESET_0: next_out = (reset) ? OUT_DEFAULT : (OUT_AG_READ | OUT_ALU_RST);
		STATE_RESET_1: next_out = (reset) ? OUT_DEFAULT : (OUT_AG_READ | OUT_ALU_RST);
		STATE_RESET_2: next_out = (reset) ? OUT_DEFAULT : 0;
		STATE_CALCULATE: next_out = (reset) ? OUT_DEFAULT : 0;
	endcase
end

endmodule
