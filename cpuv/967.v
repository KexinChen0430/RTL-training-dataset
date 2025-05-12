module quadpwm(rst_n, freq_clk, enable, mode, led);
input rst_n;        
input freq_clk;     
input enable;       
input mode;         
output pwm0;        
output pwm1;        
output pwm2;        
output pwm3;        
reg pwm0_reg;       
reg pwm1_reg;       
reg pwm2_reg;       
reg pwm3_reg;       
reg[31:0] engine_reg;
reg led;
reg [31:0] count_reg;   
reg pwm_clk;            
always @(posedge freq_clk or negedge rst_n) begin
    if (!rst_n) begin
        count_reg <= 0;    
        pwm_clk <= 0;      
    end else if (enable) begin
        if (count_reg < 999999) begin
            count_reg <= count_reg + 1;  
        end else begin
            count_reg <= 0;              
            pwm_clk <= ~pwm_clk;         
        end
    end
end
reg[31:0] pwm_load_register;
always @ (posedge pwm_clk or negedge rst_n)
begin
    if (!rst_n) begin
        pwm_load_register <= 1'b0;  
    end else if (out_div) begin     
        case (pha_reg)              
            1'd1: begin
                pha_reg <=  1'd0;   
            end
            1'd0: begin
                pha_reg <=  1'd1;   
            end
        endcase
    end
end
assign pwm0 = pwm0_reg;
endmodule