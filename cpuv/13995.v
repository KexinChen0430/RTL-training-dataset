module lm32_mc_arithmetic (
    clk_i,
    rst_i,
    stall_d,
    kill_x,
`ifdef CFG_MC_DIVIDE_ENABLED
    divide_d,
    modulus_d,
`endif
`ifdef CFG_MC_MULTIPLY_ENABLED
    multiply_d,
`endif
`ifdef CFG_MC_BARREL_SHIFT_ENABLED
    shift_left_d,
    shift_right_d,
    sign_extend_d,
`endif
    operand_0_d,
    operand_1_d,
    result_x,
`ifdef CFG_MC_DIVIDE_ENABLED
    divide_by_zero_x,
`endif
    stall_request_x
    );
input clk_i;                                    
input rst_i;                                    
input stall_d;                                  
input kill_x;                                   
`ifdef CFG_MC_DIVIDE_ENABLED
input divide_d;                                 
input modulus_d;                                
`endif
`ifdef CFG_MC_MULTIPLY_ENABLED
input multiply_d;                               
`endif
`ifdef CFG_MC_BARREL_SHIFT_ENABLED
input shift_left_d;                             
input shift_right_d;                            
input sign_extend_d;                            
`endif
input [`LM32_WORD_RNG] operand_0_d;             
input [`LM32_WORD_RNG] operand_1_d;             
output [`LM32_WORD_RNG] result_x;               
reg    [`LM32_WORD_RNG] result_x;               
`ifdef CFG_MC_DIVIDE_ENABLED
output divide_by_zero_x;                        
reg    divide_by_zero_x;                        
`endif
output stall_request_x;                         
wire   stall_request_x;                         
reg [`LM32_WORD_RNG] p;                         
reg [`LM32_WORD_RNG] a;                         
reg [`LM32_WORD_RNG] b;                         
`ifdef CFG_MC_DIVIDE_ENABLED
wire [32:0] t;                                  
`endif
reg [`LM32_MC_STATE_RNG] state;                 
reg [5:0] cycles;                               
`ifdef CFG_MC_BARREL_SHIFT_ENABLED
reg sign_extend_x;                              
wire fill_value;                                
`endif
assign stall_request_x = state != `LM32_MC_STATE_IDLE;
`ifdef CFG_MC_DIVIDE_ENABLED
assign t = {p[`LM32_WORD_WIDTH-2:0], a[`LM32_WORD_WIDTH-1]} - b;
`endif
`ifdef CFG_MC_BARREL_SHIFT_ENABLED
assign fill_value = (sign_extend_x == `TRUE) & b[`LM32_WORD_WIDTH-1];
`endif
always @(posedge clk_i `CFG_RESET_SENSITIVITY)
begin
    if (rst_i == `TRUE)
    begin
        cycles <= {6{1'b0}};                     
        p <= {`LM32_WORD_WIDTH{1'b0}};           
        a <= {`LM32_WORD_WIDTH{1'b0}};           
        b <= {`LM32_WORD_WIDTH{1'b0}};           
`ifdef CFG_MC_BARREL_SHIFT_ENABLED
        sign_extend_x <= 1'b0;                   
`endif
`ifdef CFG_MC_DIVIDE_ENABLED
        divide_by_zero_x <= `FALSE;              
`endif
        result_x <= {`LM32_WORD_WIDTH{1'b0}};    
        state <= `LM32_MC_STATE_IDLE;            
    end
    else
    begin
`ifdef CFG_MC_DIVIDE_ENABLED
        divide_by_zero_x <= `FALSE;              
`endif
        case (state)
        `LM32_MC_STATE_IDLE:
        begin
            if (stall_d == `FALSE)
            begin
                cycles <= `LM32_WORD_WIDTH;      
                p <= 32'b0;                        
                a <= operand_0_d;                
                b <= operand_1_d;                
`ifdef CFG_MC_DIVIDE_ENABLED
                if (divide_d == `TRUE)
                    state <= `LM32_MC_STATE_DIVIDE;
                if (modulus_d == `TRUE)
                    state <= `LM32_MC_STATE_MODULUS;
`endif
`ifdef CFG_MC_MULTIPLY_ENABLED
                if (multiply_d == `TRUE)
                    state <= `LM32_MC_STATE_MULTIPLY;
`endif
`ifdef CFG_MC_BARREL_SHIFT_ENABLED
                if (shift_left_d == `TRUE)
                begin
                    state <= `LM32_MC_STATE_SHIFT_LEFT;
                    sign_extend_x <= sign_extend_d;
                    cycles <= operand_1_d[4:0];
                    a <= operand_0_d;
                    b <= operand_0_d;
                end
                if (shift_right_d == `TRUE)
                begin
                    state <= `LM32_MC_STATE_SHIFT_RIGHT;
                    sign_extend_x <= sign_extend_d;
                    cycles <= operand_1_d[4:0];
                    a <= operand_0_d;
                    b <= operand_0_d;
                end
`endif
            end
        end
`ifdef CFG_MC_DIVIDE_ENABLED
        `LM32_MC_STATE_DIVIDE:
        begin
            if (t[32] == 1'b0)
            begin
                p <= t[31:0];
                a <= {a[`LM32_WORD_WIDTH-2:0], 1'b1};
            end
            else
            begin
                p <= {p[`LM32_WORD_WIDTH-2:0], a[`LM32_WORD_WIDTH-1]};
                a <= {a[`LM32_WORD_WIDTH-2:0], 1'b0};
            end
            result_x <= a;
            if ((cycles == `LM32_WORD_WIDTH'd0) || (kill_x == `TRUE))
            begin
                divide_by_zero_x <= b == {`LM32_WORD_WIDTH{1'b0}};
                state <= `LM32_MC_STATE_IDLE;
            end
            cycles <= cycles - 1'b1;
        end
        `LM32_MC_STATE_MODULUS:
        begin
            if (t[32] == 1'b0)
            begin
                p <= t[31:0];
                a <= {a[`LM32_WORD_WIDTH-2:0], 1'b1};
            end
            else
            begin
                p <= {p[`LM32_WORD_WIDTH-2:0], a[`LM32_WORD_WIDTH-1]};
                a <= {a[`LM32_WORD_WIDTH-2:0], 1'b0};
            end
            result_x <= p;
            if ((cycles == `LM32_WORD_WIDTH'd0) || (kill_x == `TRUE))
            begin
                divide_by_zero_x <= b == {`LM32_WORD_WIDTH{1'b0}};
                state <= `LM32_MC_STATE_IDLE;
            end
            cycles <= cycles - 1'b1;
        end
`endif
`ifdef CFG_MC_MULTIPLY_ENABLED
        `LM32_MC_STATE_MULTIPLY:
        begin
            if (b[0] == 1'b1)
                p <= p + a;
            b <= {1'b0, b[`LM32_WORD_WIDTH-1:1]};
            a <= {a[`LM32_WORD_WIDTH-2:0], 1'b0};
            result_x <= p;
            if ((cycles == `LM32_WORD_WIDTH'd0) || (kill_x == `TRUE))
                state <= `LM32_MC_STATE_IDLE;
            cycles <= cycles - 1'b1;
        end
`endif
`ifdef CFG_MC_BARREL_SHIFT_ENABLED
        `LM32_MC_STATE_SHIFT_LEFT:
        begin
            a <= {a[`LM32_WORD_WIDTH-2:0], 1'b0};
            result_x <= a;
            if ((cycles == `LM32_WORD_WIDTH'd0) || (kill_x == `TRUE))
                state <= `LM32_MC_STATE_IDLE;
            cycles <= cycles - 1'b1;
        end
        `LM32_MC_STATE_SHIFT_RIGHT:
        begin
            b <= {fill_value, b[`LM32_WORD_WIDTH-1:1]};
            result_x <= b;
            if ((cycles == `LM32_WORD_WIDTH'd0) || (kill_x == `TRUE))
                state <= `LM32_MC_STATE_IDLE;
            cycles <= cycles - 1'b1;
        end
`endif
        endcase
    end
end
endmodule