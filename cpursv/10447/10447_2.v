
module clock_div_50k(clk,clkcnt_reset,div_50k);

  input  clk;
  input  clkcnt_reset;
  output div_50k;
  reg  div_50k;
  reg  [19:0] cnt;

  
  always @(negedge clkcnt_reset or posedge clk)
      begin
        if (~clkcnt_reset) cnt <= 0;
        else if (cnt >= 50000) 
          begin
            div_50k <= 0;
            cnt <= 0;
          end
        else if (cnt < 25000) 
          begin
            div_50k <= 0;
            cnt <= 1+cnt;
          end
        else if ((cnt < 50000) && (cnt >= 25000)) 
          begin
            div_50k <= 1;
            cnt <= 1+cnt;
          end
          
      end
endmodule

