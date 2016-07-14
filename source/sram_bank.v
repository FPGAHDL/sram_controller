/**
* @brief two port sram block sync write asinc read
*/
module sram_bank(clk,write_enable,write_address,write_data,read_address,read_data);

parameter data_width = 8;
parameter address_depth_bits = 5;

input write_enable;
input clk;

input [address_depth_bits-1:0] write_address;
input [address_depth_bits-1:0] read_address;

input [data_width-1:0] write_data;
output [data_width-1:0] read_data;

reg [data_width-1:0] memory[(2**address_depth_bits)-1:0];

assign read_data = memory[read_address];

always@(posedge clk)begin
    if(write_enable)begin
        memory[write_address] <= write_data;
    end
end

endmodule
