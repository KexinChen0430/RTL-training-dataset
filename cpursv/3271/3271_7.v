
module pcie_7x_v1_3_fast_cfg_init_cntr  #(parameter  PATTERN_WIDTH = 8, INIT_PATTERN = 8'hA5, TCQ = 1)
  (input  clk,
   input  rst,
   output reg [(-1)+PATTERN_WIDTH:0] pattern_o);

  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            pattern_o <= #TCQ {PATTERN_WIDTH{1'b0}};
          end
        else 
          begin
            if (pattern_o != INIT_PATTERN) 
              begin
                pattern_o <= #TCQ 1+pattern_o;
              end
              
          end
      end
endmodule

