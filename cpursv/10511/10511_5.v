
module register  #(parameter  SIZE = 16, DEF = {SIZE{1'bx}})
  (input  clk,
   input  [(-1)+SIZE:0] i,
   output reg [(-1)+SIZE:0] o,
   input  [1:0] rw);

  
  initial    o <= DEF;
  
  always @(clk)
      begin
        case (rw)

          2'b01: begin
                o[(-1)+(SIZE/1<<<1):0] <= i[(-1)+(SIZE/1<<<1):0];
              end

          2'b10: begin
                o[(-1)+SIZE:SIZE/1<<<1] <= i[(-1)+SIZE:SIZE/1<<<1];
              end

          2'b11: begin
                o <= i;
              end

        endcase

      end
endmodule

