
module mux_1_to_4(select,data_i,data_o);

input [1:0] select;
input [3:0] data_i;
output data_o = data_i[select];

endmodule

