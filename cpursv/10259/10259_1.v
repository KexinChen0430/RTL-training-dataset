
module BCD_Segment_Decoder  #(parameter  BCD_DIGITS = 1)
  (input  [(0-1)+(BCD_DIGITS*4):0] BCD_IN,
   output reg [(0-1)+(7*BCD_DIGITS):0] SEG_OUT,
   input  CLK);

  
  initial  
  begin
    SEG_OUT <= {7*BCD_DIGITS{1'b0}};
  end
  genvar i;
  
  generate
      begin
        for (i = 0; i < BCD_DIGITS; i = 1+i)
            begin : bcd_to_seg_mapping
              
              always @(posedge CLK)
                  begin
                    case (BCD_IN[4*i +: 4])

                      0: SEG_OUT[7*i +: 7] <= 7'b0111111;

                      1: SEG_OUT[7*i +: 7] <= 7'b0000110;

                      1<<1: SEG_OUT[7*i +: 7] <= 7'b1011011;

                      3: SEG_OUT[7*i +: 7] <= 7'b1001111;

                      4: SEG_OUT[7*i +: 7] <= 7'b1100110;

                      5: SEG_OUT[7*i +: 7] <= 7'b1101101;

                      6: SEG_OUT[7*i +: 7] <= 7'b1111101;

                      7: SEG_OUT[7*i +: 7] <= 7'b0000111;

                      8: SEG_OUT[7*i +: 7] <= 7'b1111111;

                      9: SEG_OUT[7*i +: 7] <= 7'b1100111;

                      default: SEG_OUT[7*i +: 7] <= 7'b0000000;

                    endcase

                  end
            end
      end
  endgenerate

endmodule

