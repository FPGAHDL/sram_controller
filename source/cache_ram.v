/**
* @brief two port sram block sync write asinc read
*/
module cache_ram(reset_i,clk_i,address_i,data_o,write_data,write_address,bank_i_select,bank_enable);

parameter data_width = 8;
parameter address_depth_bits = 15;

input reset_i;
input clk_i;
input [address_depth_bits-1:0] address_i;
output reg [data_width-1:0] data_o;

wire [data_width-1:0] bank_0_data_o;
wire [data_width-1:0] bank_1_data_o;
wire [data_width-1:0] bank_2_data_o;
wire [data_width-1:0] bank_3_data_o;

wire [4:0] low_address = address_i[4:0];
wire [9:0] high_address = address_i[14:5];

wire [1:0] bank_o_select = high_address[1:0];

input bank_enable;
input [1:0] bank_i_select;
reg [3:0] bank_i_enable;

input [4:0] write_address;
input [data_width-1:0] write_data;

always@(*)begin
    bank_i_enable = 0;
    bank_i_enable[bank_i_select] = bank_enable;
end

sram_bank bank_0 (
    .write_address(write_address),
    .write_data(write_data),
    .clk(clk_i),
    .write_enable(bank_i_enable[0]),
    .read_address(low_address),
    .read_data(bank_0_data_o)
);

sram_bank bank_1 (
    .write_address(write_address),
    .write_data(write_data),
    .clk(clk_i),
    .write_enable(bank_i_enable[1]),
    .read_address(low_address),
    .read_data(bank_1_data_o)
);

sram_bank bank_2 (
    .write_address(write_address),
    .write_data(write_data),
    .clk(clk_i),
    .write_enable(bank_i_enable[2]),
    .read_address(low_address),
    .read_data(bank_2_data_o)
);

sram_bank bank_3 (
    .write_address(write_address),
    .write_data(write_data),
    .clk(clk_i),
    .write_enable(bank_i_enable[3]),
    .read_address(low_address),
    .read_data(bank_3_data_o)
);

wire [data_width-1:0] unreg_data_o;

mux_4_to_1 output_mux(
    .select(bank_o_select),
    .data_i_0(bank_0_data_o),
    .data_i_1(bank_1_data_o),
    .data_i_2(bank_2_data_o),
    .data_i_3(bank_3_data_o),
    .data_o(unreg_data_o)
);

always@(posedge clk_i)begin
    data_o <= unreg_data_o;
end

endmodule
