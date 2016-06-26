`timescale 1ns / 1ps

module fifo_test;

    // Inputs
    reg clk_read;
    reg clk_write;
    reg [15:0] input_data;
    reg write_enable;
    reg read_enable;

    // Outputs
    wire [15:0] output_data;
    wire fifo_full;
    wire fifo_empty;

    // Instantiate the Unit Under Test (UUT)
    fifo uut (
        .clk_read(clk_read),
        .clk_write(clk_write),
        .input_data(input_data),
        .output_data(output_data),
        .write_enable(write_enable),
        .read_enable(read_enable),
        .fifo_full(fifo_full),
        .fifo_empty(fifo_empty)
    );

    initial begin
        // Initialize Inputs
        clk_read = 0;
        clk_write = 0;
        input_data = 256;
        write_enable = 1;
        read_enable = 0;

        //write to full
        repeat(16)begin
            #10;
            clk_write = 1;
            #10;
            clk_write = 0;
            input_data = input_data + 1;
        end

        //read to empty
        write_enable = 0;
        read_enable = 1;

        repeat(16)begin
            #10;
            clk_read = 1;
            #10;
            clk_read = 0;
        end

    end

endmodule

