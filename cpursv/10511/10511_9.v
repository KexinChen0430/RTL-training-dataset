
module register  #(parameter  SIZE = 16, DEF = {SIZE{1'bx}})
  (input  clk,
   input  [(0-1)+SIZE:0] i,
   output reg [(0-1)+SIZE:0] o,
   input  [1:0] rw);

  
  initial    o <= DEF;
  
  always @(clk)
      begin
        case (rw)

          2'b01: begin
                o[(0-1)+(SIZE/2):0] <= i[(0-1)+(SIZE/2):0];
              end

          2'b10: begin
                o[(0-1)+SIZE:SIZE/2] <= i[(0-1)+SIZE:SIZE/2];
              end

          2'b11: begin
                o <= i;
              end

        endcase

      end
endmodule

