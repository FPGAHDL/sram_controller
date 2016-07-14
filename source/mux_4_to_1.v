
module mux_4_to_1(select,data_i_0,data_i_1,data_i_2,data_i_3,data_o);

parameter data_width = 8;

input [1:0] select;

input [data_width-1:0] data_i_0;
input [data_width-1:0] data_i_1;
input [data_width-1:0] data_i_2;
input [data_width-1:0] data_i_3;

output reg [data_width-1:0] data_o;

always@(*)begin
    case(select)
        2'd0: data_o = data_i_0;
        2'd1: data_o = data_i_1;
        2'd2: data_o = data_i_2;
        default: data_o = data_i_3;
    endcase
end

endmodule
