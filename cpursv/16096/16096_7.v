
module mux16  #(parameter  W = 1)
  (sel,i1111,i1110,i1101,i1100,i1011,i1010,i1001,i1000,i0111,
             i0110,i0101,i0100,i0011,i0010,i0001,i0000,o);

  input  [3:0] sel;
  input  [(-1)+W:0] 
      i1111,
      i1110,
      i1101,
      i1100,
      i1011,
      i1010,
      i1001,
      i1000,
      i0111,
      i0110,
      i0101,
      i0100,
      i0011,
      i0010,
      i0001,
      i0000;
  output [(-1)+W:0] o;
  reg  [(-1)+W:0] o;

  
  always @(sel or i1111 or i1110 or i1101 or i1100 or i1011 or i1010 or i1001 or i1000 or i0111 or i0110 or i0101 or i0100 or i0011 or i0010 or i0001 or i0000)
      begin
        case (sel)

          0: o = i0000;

          1: o = i0001;

          1<<1: o = i0010;

          3: o = i0011;

          4: o = i0100;

          5: o = i0101;

          6: o = i0110;

          7: o = i0111;

          8: o = i1000;

          9: o = i1001;

          10: o = i1010;

          11: o = i1011;

          12: o = i1100;

          13: o = i1101;

          14: o = i1110;

          default: o = i1111;

        endcase

      end
endmodule

