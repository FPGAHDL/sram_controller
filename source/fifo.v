
module fifo(clk_read,clk_write,input_data,output_data,write_enable,read_enable,fifo_full,fifo_empty);

parameter data_width = 16;
parameter fifo_depth_bits = 4;

input clk_read;
input clk_write;

input [data_width-1:0] input_data;

input write_enable;
input read_enable;

output reg [data_width-1:0] output_data;

output fifo_full;
output fifo_empty;

reg [data_width-1:0] internal_memory[(2**fifo_depth_bits)-1:0];

reg [fifo_depth_bits-1:0] read_pointer = 0;
reg [fifo_depth_bits-1:0] write_pointer = 0;

assign fifo_empty = (read_pointer == write_pointer);
wire [fifo_depth_bits-1:0]index_diff = write_pointer - read_pointer;
assign fifo_full = (index_diff == ((2**fifo_depth_bits)-1));

always@(posedge clk_read)begin
    if(read_enable && (!fifo_empty))begin
        output_data <= internal_memory[read_pointer];
        read_pointer <= read_pointer + 1;
    end
end

always@(posedge clk_write)begin
    if(write_enable && (!fifo_full))begin
        internal_memory[write_pointer] <= input_data;
        write_pointer <= write_pointer + 1;
    end
end

endmodule
