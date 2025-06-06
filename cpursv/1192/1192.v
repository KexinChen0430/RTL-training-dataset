
module number_to_seg(input  [7:0] d,
                     output [6:0] seg);

  assign seg = (d == 0) ? 7'b1000000 : 
               (d == 1) ? 7'b1111001 : 
               (d == 2) ? 7'b0100100 : 
               (d == 3) ? 7'b0110000 : 
               (d == 4) ? 7'b0011001 : 
               (d == 5) ? 7'b0010010 : 
               (d == 6) ? 7'b0000010 : 
               (d == 7) ? 7'b1111000 : 
               (d == 8) ? 7'b0000000 : 
               (d == 9) ? 7'b0010000 : 7'b1000000;
endmodule

