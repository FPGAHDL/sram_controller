
module write_fsm(
    clk,
    input_address,
    input_data,
    sram_data,
    sram_address,
    sram_cs,
    start,
    done
);

parameter data_width = 16;
parameter address_width = 16;


input clk;

input [address_width-1:0] input_address;
input [data_width-1:0] input_data;

output reg [address_width-1:0] sram_address;
output reg [data_width-1:0] sram_data;
output reg sram_cs;

input  start;
output reg  done;

localparam number_of_states = 5;

localparam state_idle = 0;
localparam state_write_1 = 1 << 0;
localparam state_write_2 = 1 << 1;
localparam state_write_3 = 1 << 2;
localparam state_hold = 1 << 3;

reg [number_of_states-1:0] current_state = 0;
reg [number_of_states-1:0] next_state;

always@(posedge clk)begin
    current_state <= next_state;
end

always@(*)begin
    next_state = state_idle;
    if(current_state == state_idle && start == 1)
        next_state = state_write_1;
    else if(current_state == state_write_1)
        next_state = state_write_2;
    else if(current_state == state_write_2)
        next_state = state_write_3;
    else if(current_state == state_write_3)
        next_state = state_hold;
    else if(current_state == state_hold)
        next_state = state_idle;
end

always@(posedge clk)begin
    if(current_state == state_idle && next_state == state_write_1)begin
        sram_data <= input_data;
        sram_address <= input_address;
    end
end

always@(*)begin
    done = 0;
    sram_cs = 1; 

    if(current_state == state_idle)
        done = 1;
    if(current_state == state_write_1 || current_state == state_write_2 ||current_state == state_write_3)
        sram_cs = 0;
end

endmodule
