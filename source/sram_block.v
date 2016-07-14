
module sram_block(i_address,i_data,i_clk,write_enable,o_address,o_data);

parameter data_width = 8;
parameter address_depth_bits = 12;

input write_enable;
input i_clk;

input [address_depth_bits-1:0] i_address;
input [address_depth_bits-1:0] o_address;

input [data_width-1:0] i_data;
output reg [data_width-1:0] o_data;

reg [data_width-1:0] memory[(2**address_depth_bits)-1:0];

always@(posedge i_clk)begin
    if(write_enable)begin
        memory[i_address] <= i_data;
    end
    o_data <= memory[o_address];
    
end

endmodule
