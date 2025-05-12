
module counterModulo(clk,modulo,count,oClk);

  parameter  n = 10, safe = 1;
  input  clk;
  input  [(-1)+n:0] modulo;
  output reg [(-1)+n:0]  count = 0;
  output oClk;

  assign oClk = ((count+1) == modulo) ? 1 : 
                ((count+1) < modulo) ? 0 : 
                safe ? 1 : 1'bx;
  
  always @(posedge clk)
      if (!oClk) count <= count+1;
      else count <= 0;
endmodule

