
module bus_register  #(parameter  SIZE = 16)
  (input  clk,
   input  [SIZE+(0-1):0] i,
   output reg [SIZE+(0-1):0] o);

  
  always @(clk)  begin
    o <= i;
  end
endmodule

