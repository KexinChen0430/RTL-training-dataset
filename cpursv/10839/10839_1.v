
module fixeddivby2(input  clk,
                   input  cein,
                   output ceout);

  reg  q;

  
  initial    q = 0;
  assign ceout = q & cein;
  
  always @(posedge clk)
      begin
        if (cein) q = ~q;
          
      end
endmodule

