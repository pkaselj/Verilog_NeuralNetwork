`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:55:28 04/12/2022
// Design Name:   NeuralAccelerator
// Module Name:   /home/ise/Desktop/NerualNetwork/NeuralAccelerator_test.v
// Project Name:  NerualNetwork
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: NeuralAccelerator
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module NeuralAccelerator_test;

	reg clk, reset;
	reg [10:0] 		neuron_ram_write_adr_ext,
						neuron_ram_read_adr_ext;
	reg [7:0]		neuron_ram_write_data_ext;
	reg 	 			neuron_ram_wr_en_ext;
	
	wire 				finished;
	wire [10:0] 	result_base_address,
						result_word_count;
	wire [7:0]		neuron_ram_read_data_ext;

	// Instantiate the Unit Under Test (UUT)
	NeuralAccelerator uut (
		.clk(clk),
		.reset(reset),
		.neuron_ram_write_adr_ext(neuron_ram_write_adr_ext),
		.neuron_ram_write_data_ext(neuron_ram_write_data_ext),
		.neuron_ram_read_adr_ext(neuron_ram_read_adr_ext),
		.neuron_ram_wr_en_ext(neuron_ram_wr_en_ext),
		.finished(finished),
		.result_base_address(result_base_address),
		.result_word_count(result_word_count),
		.neuron_ram_read_data_ext(neuron_ram_read_data_ext)
	);
	
	integer fd;
	
	always @(posedge clk) begin
		if(!reset && !finished)
		$fwrite(
			fd,
			"%d,%d,%d,%d,%d,%d,%d,%d,%d\n",
			$signed(uut.ALU.internal_weight),
			$signed(uut.ALU.internal_value),
			$signed(uut.ALU.weight_mpy_value),
			$signed(uut.ALU.accumulator),
			$signed(uut.ALU.result),
			$signed(uut.ALU.result_downscaled),
			$signed(uut.neuro_read_address),
			$signed(uut.neuro_write_address),
			$signed(uut.weight_read_address)
		);
	end
	
	initial begin
	
		// Initialize Inputs
		clk = 0;
		reset = 1;
		neuron_ram_read_adr_ext = 0;
		neuron_ram_write_adr_ext = 0;
		neuron_ram_write_data_ext = 0;
		neuron_ram_wr_en_ext = 0;
		
		fd = $fopen("output.txt", "w");
		
		$fwrite(fd,
			"internal_weight,internal_value,weight_mpy_value,accumulator,result,result_downscaled,neuro_read_addr,neuro_wr_addr,weight_read_addr\n"
		);
		
//		$fwrite(
//			fd,
//			"%d,%d,%d,%d,%d,%d,%d,%d,%d\n",
//			$signed(uut.ALU.internal_weight),
//			$signed(uut.ALU.internal_value),
//			$signed(uut.ALU.weight_mpy_value),
//			$signed(uut.ALU.accumulator),
//			$signed(uut.ALU.result),
//			$signed(uut.ALU.result_downscaled),
//			$signed(uut.neuro_read_address),
//			$signed(uut.neuro_write_address),
//			$signed(uut.weight_read_address)
//			);
		
//		#1
//		neuron_ram_write_adr_ext = 0;
//		neuron_ram_write_data_ext = 8'd2;
//		
//		#4
//		neuron_ram_write_adr_ext = 1;
//		neuron_ram_write_data_ext = 8'd3;
//		
//		#4
//		neuron_ram_write_adr_ext = 2;
//		neuron_ram_write_data_ext = 8'd7;
//		
//		#4
//		neuron_ram_write_adr_ext = 3;
//		neuron_ram_write_data_ext = 8'd4;
//		
//		#4
//		neuron_ram_write_adr_ext = 4;
//		neuron_ram_write_data_ext = 8'd1;
//		
//		#4 neuron_ram_wr_en_ext = 0;

		
		
		#5; reset = 0;
		
		#40000 $fclose(fd);
		#10 $stop;
		
//		#1000 reset = 1;
//		#15$stop;
        
		// Add stimulus here

	end
      
	always begin
		#2 clk = ~clk;
	end
	
	always @(posedge clk) begin
		if(finished) begin
			neuron_ram_read_adr_ext <= neuron_ram_read_adr_ext + 1;
		end
	end
endmodule

