
module program_counter  #(parameter  SIZE = 16)
  (input  clk,
   input  [(0-1)+SIZE:0] i,
   output reg [(0-1)+SIZE:0] o,
   input  rw,
   input  [1:0] inc);

  
  initial    o <= 0;
  
  always @(clk)
      begin
        case (inc)

          2'b00: begin
                if (rw) o <= i;
                  
              end

          2'b01: o <= o+1<<1;

          2'b10: o <= o+4;

          2'b11: o <= 6+o;

        endcase

      end
endmodule

