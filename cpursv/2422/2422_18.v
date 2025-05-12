
module crc7  #(parameter  POLYNOMIAL = 8'h09, SEED = 8'h00)
  (input  clk,
   input  rst,
   input  bit,
   output reg [6:0] crc,
   input  en);

  wire inv;

  assign inv = (~crc[6] | (~bit & crc[6])) & (bit | ((bit & crc[6]) | (~bit & crc[6])));
  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            crc <= SEED;
          end
        else 
          begin
            if (en) 
              begin
                crc[6] <= crc[5];
                crc[5] <= crc[4];
                crc[4] <= crc[3];
                crc[3] <= (crc[2] & ((crc[2] | ~crc[2]) | ((crc[2] | inv) & ((inv | ~inv) & ~crc[2])))) ^ (((crc[2] | ~crc[2]) | ((crc[2] | inv) & ((inv | ~inv) & ~crc[2]))) & (inv & (crc[2] | ~crc[2])));
                crc[2] <= crc[1];
                crc[1] <= crc[0];
                crc[0] <= inv;
              end
              
          end
      end
endmodule

