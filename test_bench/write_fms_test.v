`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   02:51:32 06/25/2016
// Design Name:   write_fsm
// Module Name:   /home/manuel/Documents/myCode/hdl/verilog/sdram_controller/test_bench/write_fms_test.v
// Project Name:  sdram_controller
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: write_fsm
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module write_fms_test;

	// Inputs
	reg clk;
	reg [15:0] input_address;
	reg [15:0] input_data;
	reg start;

	// Outputs
	wire [15:0] sram_data;
	wire [15:0] sram_address;
	wire sram_cs;
	wire done;

	// Instantiate the Unit Under Test (UUT)
	write_fsm uut (
		.clk(clk), 
		.input_address(input_address), 
		.input_data(input_data), 
		.sram_data(sram_data), 
		.sram_address(sram_address), 
		.sram_cs(sram_cs), 
		.start(start), 
		.done(done)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		input_address = 0;
		input_data = 0;
		start = 0;

		// Wait 100 ns for global reset to finish
		#100;
        input_address = 100;
		input_data = 10;
        start = 1;
        clk = 1;
        #10
        clk = 0;
        start = 0;
        repeat(4) begin
            #10
            clk = 1;
            #10
            clk = 0;
        end		
		// Add stimulus here

	end
      
endmodule

