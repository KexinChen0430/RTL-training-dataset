module EHRU_6 ( 
    CLK,
    read_0,
    write_0,
    EN_write_0,
    read_1,
    write_1,
    EN_write_1,
    read_2,
    write_2,
    EN_write_2,
    read_3,
    write_3,
    EN_write_3,
    read_4,
    write_4,
    EN_write_4,
    read_5,
    write_5,
    EN_write_5
);
    parameter            DATA_SZ = 1; 
    parameter            RESET_VAL = 0; 
    input                CLK; 
    output [DATA_SZ-1:0] read_0; 
    input  [DATA_SZ-1:0] write_0; 
    input                EN_write_0; 
    output [DATA_SZ-1:0] read_1; 
    input  [DATA_SZ-1:0] write_1;
    input                EN_write_1;
    output [DATA_SZ-1:0] read_2; 
    input  [DATA_SZ-1:0] write_2;
    input                EN_write_2;
    output [DATA_SZ-1:0] read_3; 
    input  [DATA_SZ-1:0] write_3;
    input                EN_write_3;
    output [DATA_SZ-1:0] read_4; 
    input  [DATA_SZ-1:0] write_4;
    input                EN_write_4;
    output [DATA_SZ-1:0] read_5; 
    input  [DATA_SZ-1:0] write_5;
    input                EN_write_5;
    reg    [DATA_SZ-1:0] r; 
    wire   [DATA_SZ-1:0] wire_0; 
    wire   [DATA_SZ-1:0] wire_1;
    wire   [DATA_SZ-1:0] wire_2;
    wire   [DATA_SZ-1:0] wire_3;
    wire   [DATA_SZ-1:0] wire_4;
    wire   [DATA_SZ-1:0] wire_5;
    wire   [DATA_SZ-1:0] wire_6;
    assign wire_0 = r; 
    assign wire_1 = EN_write_0 ? write_0 : wire_0; 
    assign wire_2 = EN_write_1 ? write_1 : wire_1; 
    assign wire_3 = EN_write_2 ? write_2 : wire_2;
    assign wire_4 = EN_write_3 ? write_3 : wire_3;
    assign wire_5 = EN_write_4 ? write_4 : wire_4;
    assign wire_6 = EN_write_5 ? write_5 : wire_5;
    assign read_0 = wire_0; 
    assign read_1 = wire_1; 
    assign read_2 = wire_2;
    assign read_3 = wire_3;
    assign read_4 = wire_4;
    assign read_5 = wire_5;
    always @(posedge CLK) begin 
        r <= wire_6; 
    end
endmodule 