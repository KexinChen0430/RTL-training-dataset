
module stratix_pll_reg(q,clk,ena,d,clrn,prn);

  input  d;
  input  clk;
  input  clrn;
  input  prn;
  input  ena;
  output q;
  reg  q;
  tri1 prn,clrn,ena;

  
  initial    q = 0;
  
  always @(posedge clk or negedge clrn or negedge prn)
      begin
        if (prn == 1'b0) q <= 1;
        else if (clrn == 1'b0) q <= 0;
        else if ((clk == 1) & (ena == 1'b1)) q <= d;
          
      end
endmodule

