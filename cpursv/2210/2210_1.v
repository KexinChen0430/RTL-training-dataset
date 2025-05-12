
module TFlipFlop(input  t,
                 input  clk,
                 output reg q);

  
  always @(posedge t)
      begin
        if (t) q = ~q;
          
      end
endmodule

