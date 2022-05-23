`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
//
// 8-bit UART transmiter, no parity bit
//
//
//////////////////////////////////////////////////////////////////////////////////
module UART_TX(
	input clk, enable,
	input [7:0] data_in,
	output reg tx, done
	);

	parameter state_idle = 2'b00;
	parameter state_start = 2'b01;
	parameter state_data = 2'b10;
	parameter state_stop = 2'b11;
	parameter clk_per_bit = 5208; //Must be set correctly: 
										 //clk_per_bit = clk_frequency / baud_rate
										 //max is 65535


	reg [15:0] clk_count;
	reg [2:0] index;
	reg [7:0] data_temp;
	reg [1:0] state; 
	
	
	initial begin
		done <= 0;
		tx <= 1;
		state <= state_idle;
	end 
	  
	always@(posedge clk) begin 
		case(state)
			state_idle: begin
				tx <= 1;
				done <= 0;
				clk_count <= 0;
				index <= 0;
				if(enable) begin
					data_temp <= data_in;
					state <= state_start; 
				end
				else
					state <= state_idle;
			end
			
			state_start: begin
				tx <= 0;
				if(clk_count <= clk_per_bit - 1) begin
					clk_count <= clk_count + 1;
				end
				else begin
					clk_count <= 0;
					state <= state_data;
				end
			end
			
			state_data: begin
				tx <= data_temp[index];
				if(clk_count < clk_per_bit - 1) begin
					clk_count <= clk_count + 1;
					state <= state_data;
				end
				else begin
					clk_count <= 0;
					if(index < 7) begin
						index <= index + 1;
						state <= state_data;
					end
					else begin
						index <= 0;
						state <= state_stop;
					end
				end
			end
			
			state_stop: begin
				tx <= 1;
				if (clk_count < clk_per_bit - 1) begin
					clk_count <= clk_count + 1;
					state <= state_stop;
				end
				else begin
					done <= 1;
					clk_count <= 0;
					state <= state_idle;
				end
			end
			
			default: begin
				state <= state_idle;
				index <= 0;
				clk_count <= 0;
				tx <= 1;
			end
		endcase
	end
	
	
	
endmodule
