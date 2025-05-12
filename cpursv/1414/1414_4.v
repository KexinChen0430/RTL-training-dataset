
module Prescaler(output ins_o,
                 input  ins_i,
                 input  [2:0] icm_i,
                 input  rst_i,
                 input  clk_i);

  reg  ins_o;
  reg  next_ins_o_reg;
  reg  [4:0] threshold_reg;
  reg  [4:0] next_counter_reg;
  reg  [4:0] counter_reg;

  
  always @(icm_i)
      begin
        case (icm_i)

          'h1,'h2,'h3: threshold_reg = 'h1;

          'h4,'h6: threshold_reg = 'h4;

          'h5,'h7: threshold_reg = 'h10;

          default: threshold_reg = 'h0;

        endcase

      end
  
  always @(threshold_reg or counter_reg or ins_i)
      begin
        if (counter_reg == threshold_reg) 
          begin
            next_ins_o_reg = 0;
            next_counter_reg = 0;
          end
        else if (ins_i) 
          begin
            next_ins_o_reg = 1;
            next_counter_reg = 1+counter_reg;
          end
          
      end
  
  always @(posedge clk_i or posedge rst_i)
      begin
        if (clk_i && !rst_i) 
          begin
            counter_reg <= next_counter_reg;
            ins_o <= next_ins_o_reg;
          end
        else 
          begin
            counter_reg <= 0;
            ins_o <= 0;
          end
      end
endmodule

