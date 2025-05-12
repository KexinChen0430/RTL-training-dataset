module Keyboard_driver(
    input clk,               
    input reset,             
    input ready_pulse,       
    input [7:0] Keyboard_Data, 
    input STB,               
    output ACK,              
    output [31:0] DAT_O      
);
    reg [31:0] data_hold = 0; 
    reg [7:0] data_cooked;    
    reg [23:0] data_cnt = 0;  
    reg f0 = 0;               
    assign DAT_O = {data_cooked, data_cnt}; 
    assign ACK = STB; 
    always @(posedge ready_pulse) begin
        if (Keyboard_Data == 8'hf0)
            f0 <= 1; 
        else begin
            if (!f0) begin
                data_hold <= Keyboard_Data; 
                data_cnt <= data_cnt + 1;  
            end else
                f0 <= 0; 
        end
    end
    always @* begin
        case(data_hold)
            8'h16: data_cooked = 49; 
            8'h1E: data_cooked = 50; 
            8'h5A: data_cooked = 10; 
            default: data_cooked = 0; 
        endcase
    end
endmodule