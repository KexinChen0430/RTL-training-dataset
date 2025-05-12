module Control_Unit(
    output reg done,           
    output reg Ld_AR_BR,       
    output reg Div_AR_x2_CR,   
    output reg Mul_BR_x2_CR,   
    output reg Clr_CR,         
    input reset_b,             
    input start,               
    input AR_gt_0,             
    input AR_lt_0,             
    input clk                  
);
    always @(posedge clk) begin
        if (start) begin
            Ld_AR_BR = 1;         
            Mul_BR_x2_CR = 0;     
            Div_AR_x2_CR = 0;     
            Clr_CR = 0;           
            done = 0;             
        end else begin
            if (AR_gt_0) begin
                Ld_AR_BR = 0;     
                Mul_BR_x2_CR = 1; 
                Div_AR_x2_CR = 0; 
                Clr_CR = 0;       
                done = 1;         
            end else if (AR_lt_0) begin
                Ld_AR_BR = 0;     
                Mul_BR_x2_CR = 0; 
                Div_AR_x2_CR = 1; 
                Clr_CR = 0;       
                done = 1;         
            end else begin
                Ld_AR_BR = 0;     
                Mul_BR_x2_CR = 0; 
                Div_AR_x2_CR = 0; 
                Clr_CR = 1;       
                done = 1;         
            end
        end
    end
    always @(reset_b) begin
        if (reset_b == 0) begin
            Ld_AR_BR = 0;         
            Mul_BR_x2_CR = 0;     
            Div_AR_x2_CR = 0;     
            Clr_CR = 0;           
            done = 0;             
        end
    end
endmodule