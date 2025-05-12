
module program_counter  #(parameter  SIZE = 16)
  (input  clk,
   input  [SIZE+(-1):0] i,
   output reg [SIZE+(-1):0] o,
   input  rw,
   input  [1:0] inc);

  
  initial    o <= 0;
  
  always @(clk)
      begin
        case (inc)

          2'b00: begin
                if (rw) o <= i;
                  
              end

          2'b01: o <= (1+1)+o;

          2'b10: o <= 4+o;

          2'b11: o <= 6+o;

        endcase

      end
endmodule

