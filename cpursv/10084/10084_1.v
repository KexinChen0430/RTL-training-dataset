
module acc_clk(input  clk,
               output dev_clk);

  parameter  TICKS = 9;
  reg  [3:0]  count = 0;
  reg   sig_reg = 0;

  
  always @(posedge clk)
      begin
        if (count == TICKS) 
          begin
            sig_reg <= ~sig_reg;
            count <= 0;
          end
        else 
          begin
            count <= 1+count;
          end
      end
  assign dev_clk = sig_reg;
endmodule

