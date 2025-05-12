
module HEXto7Segment(HEXnumber,Segments);

  input  [3:0] HEXnumber;
  output reg [7:0] Segments;

  
  always @(HEXnumber)
      case (HEXnumber)

        0: Segments <= 8'b11000000;

        1: Segments <= 8'b11111001;

        2: Segments <= 8'b10100100;

        3: Segments <= 8'b10110000;

        4: Segments <= 8'b10011001;

        5: Segments <= 8'b10010010;

        6: Segments <= 8'b10000010;

        7: Segments <= 8'b11111000;

        8: Segments <= 8'b10000000;

        9: Segments <= 8'b10010000;

        10: Segments <= 8'b10001000;

        11: Segments <= 8'b10000011;

        12: Segments <= 8'b11000110;

        13: Segments <= 8'b10100001;

        14: Segments <= 8'b10000110;

        15: Segments <= 8'b10001110;

        default: Segments <= 8'b00000000;

      endcase

endmodule

