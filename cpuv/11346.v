module control_leer(clk,load_e,efect0,add_1,add_2,reset_1,reset_2,top_1,top_2,load_crt,done_crt,new_col,reset_new,load_led,rst,run_efect);
    input clk; 
    input load_e; 
    input efect0; 
    input top_1; 
    input top_2; 
    input done_crt; 
    input new_col; 
    input run_efect; 
    output reg rst; 
    output reg add_1; 
    output reg add_2; 
    output reg reset_1; 
    output reg reset_2; 
    output reg load_crt; 
    output reg reset_new; 
    output reg load_led; 
    reg [6:0] current_state; 
    reg [6:0] next_state; 
    parameter start=7'b0000000, state_1=7'b0000001, state_2=7'b0000010, state_3=7'b0000011, state_4=7'b0000100, state_5=7'b0000101, state_6=7'b0000110,state_3f=7'b0000111;
    always @(top_1 or run_efect or load_e or efect0 or  top_2 or done_crt or new_col or current_state)begin
        case(current_state)
            start:  
            state_1: 
            state_2: 
            state_3: 
            state_3f: 
            state_4: 
            state_5: 
            state_6: 
            default: 
        endcase
    end
    always @(negedge clk) begin
        current_state<=next_state;
    end
endmodule