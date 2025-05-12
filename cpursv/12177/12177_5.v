
module register  #(parameter  N = 8)
  (input  clk,
   input  [(0-1)+N:0] in,
   output reg [(0-1)+N:0] out,
   input  load,
   input  clear);

  
  always @(posedge clk or posedge clear)
      if (clear) out <= 0;
      else if (load) out <= in;
      else out <= in;
endmodule

