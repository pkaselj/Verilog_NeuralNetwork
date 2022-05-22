`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
//
// 8-bit UART receiver, no parity bit
//
//
//////////////////////////////////////////////////////////////////////////////////
module UART_RX(
	input clk, rx, enable,
	output reg [7:0] data_out,
	output reg done, test,
	output reg [1:0] test_state
	);

	parameter state_idle = 2'b00;
	parameter state_start = 2'b01;
	parameter state_data = 2'b10;
	parameter state_stop = 2'b11;
	parameter clk_per_bit = 32; //Must be set correctly: 
										 //clk_per_bit = clk_frequency / baud_rate
										 //max is 255


	reg [7:0] clk_count;
	reg [2:0] index;
	reg [7:0] data_temp;
	reg [1:0] state;
	 
	
	initial begin
		done <= 0;
		data_out <= 0;
		test <= 0;
		state <= state_idle;
	end
	  
	always@(posedge clk) begin 
		case(state)
			state_idle: begin
				clk_count <= 0;
				index <= 0;
				done <= 0;			
				if (rx == 0) begin
					state <= state_start;
				end
				else begin 
					state <= state_idle; 		
				end
			end
			
			state_start: begin
				if(clk_count == (clk_per_bit-1)/2) begin
					if(rx == 0) begin
						clk_count <= 0;
						state <= state_data;  
					end
					else begin
						state <= state_idle;
					end
				end
				else begin
					clk_count <= clk_count + 1;
					state <= state_start;
				end
			end
			
			state_data: begin
				if(clk_count < clk_per_bit - 1) begin
					clk_count <= clk_count + 1;
					state <= state_data;
				end
				else begin
					clk_count <= 0;
					data_temp[index] <= rx;
					
					if(index == 7) begin
						index <= 0;
						state <= state_stop;
					end
					else begin
						index <= index + 1;
						state <= state_data; 
					end
				end
			end
			
			state_stop: begin
				if(clk_count < clk_per_bit - 1) begin
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
			end
		endcase
	end
	
	always@(posedge clk) begin
		test_state <= state;
	end
	
	always@(posedge clk) begin
		if(done)
			data_out <= data_temp; 
	end
endmodule
