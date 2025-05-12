
module seg7enc(input  [3:0] dat,
               output [6:0] seg);

  reg  [6:0] seg_inv;

  
  always @* 
      begin
        seg_inv = 0;
        case (dat)

          4'h0: seg_inv = 7'b0111111;

          4'h1: seg_inv = 7'b0000110;

          4'h2: seg_inv = 7'b1011011;

          4'h3: seg_inv = 7'b1001111;

          4'h4: seg_inv = 7'b1100110;

          4'h5: seg_inv = 7'b1101101;

          4'h6: seg_inv = 7'b1111101;

          4'h7: seg_inv = 7'b0000111;

          4'h8: seg_inv = 7'b1111111;

          4'h9: seg_inv = 7'b1101111;

          4'hA: seg_inv = 7'b1110111;

          4'hB: seg_inv = 7'b1111100;

          4'hC: seg_inv = 7'b0111001;

          4'hD: seg_inv = 7'b1011110;

          4'hE: seg_inv = 7'b1111001;

          4'hF: seg_inv = 7'b1110001;

        endcase

      end
  assign seg = ~seg_inv;
endmodule

