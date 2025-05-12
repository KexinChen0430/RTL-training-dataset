
module simple_register  #(parameter  SIZE = 16)
  (input  clk,
   input  [(-1)+SIZE:0] i,
   output reg [(-1)+SIZE:0] o,
   input  rw);

  
  always @(clk)
      begin
        if (rw) 
          begin
            o <= i;
          end
          
      end
endmodule

