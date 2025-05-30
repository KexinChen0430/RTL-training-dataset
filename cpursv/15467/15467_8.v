
module counterModulo(clk,modulo,count,oClk);

  parameter  n = 10, safe = 1;
  input  clk;
  input  [(0-1)+n:0] modulo;
  output reg [(0-1)+n:0]  count = 0;
  output oClk;

  assign oClk = ((1+count) == modulo) ? 1 : 
                ((1+count) < modulo) ? 0 : 
                safe ? 1 : 1'bx;
  
  always @(posedge clk)
      if (!oClk) count <= 1+count;
      else count <= 0;
endmodule

