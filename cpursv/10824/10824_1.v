
module Seven(sin,sout);

  input  [3:0] sin;
  output [6:0] sout;
  reg  [6:0] sout;

  
  always @(sin)
      begin
        case (sin)

          4'b0000: sout = 7'b1000000;

          4'b0001: sout = 7'b1111001;

          4'b0010: sout = 7'b0100100;

          4'b0011: sout = 7'b0110000;

          4'b0100: sout = 7'b0011001;

          4'b0101: sout = 7'b0010010;

          4'b0110: sout = 7'b0000010;

          4'b0111: sout = 7'b1111000;

          4'b1000: sout = 7'b0000000;

          4'b1001: sout = 7'b0010000;

          4'b1010: sout = 7'b0001000;

          4'b1011: sout = 7'b0000011;

          4'b1100: sout = 7'b1000110;

          4'b1101: sout = 7'b0100001;

          4'b1110: sout = 7'b0000110;

          4'b1111: sout = 7'b0001110;

        endcase

      end
endmodule

