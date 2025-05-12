
module bus_register  #(parameter  SIZE = 16)
  (input  clk,
   input  [(0-1)+SIZE:0] i,
   output reg [(0-1)+SIZE:0] o);

  
  always @(clk)  begin
    o <= i;
  end
endmodule

