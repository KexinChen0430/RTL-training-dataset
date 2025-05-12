
module crc16  #(parameter  POLYNOMIAL = 16'h1021, SEED = 16'h0000)
  (input  clk,
   input  rst,
   input  en,
   input  bit,
   output reg [15:0] crc);

  wire inv;

  assign inv = ((~crc[15] | (~bit & (((crc[15] | ~crc[15]) & ((crc[15] & bit) ^ (bit & (crc[15] & bit)))) ^ ((crc[15] | ~crc[15]) & (crc[15] ^ (crc[15] & (((crc[15] | ~crc[15]) & bit) & crc[15]))))))) & (crc[15] & ((~bit | bit) | ((~bit & (((crc[15] | ~crc[15]) & ((crc[15] & bit) ^ (bit & (crc[15] & bit)))) ^ ((crc[15] | ~crc[15]) & (crc[15] ^ (crc[15] & (((crc[15] | ~crc[15]) & bit) & crc[15])))))) | ((~crc[15] & (crc[15] | ((crc[15] | ~crc[15]) & bit))) & ~bit))))) ^ ((~crc[15] | (~bit & (((crc[15] | ~crc[15]) & ((crc[15] & bit) ^ (bit & (crc[15] & bit)))) ^ ((crc[15] | ~crc[15]) & (crc[15] ^ (crc[15] & (((crc[15] | ~crc[15]) & bit) & crc[15]))))))) & (((crc[15] | ~crc[15]) & bit) & ((~bit | bit) | ((~bit & (((crc[15] | ~crc[15]) & ((crc[15] & bit) ^ (bit & (crc[15] & bit)))) ^ ((crc[15] | ~crc[15]) & (crc[15] ^ (crc[15] & (((crc[15] | ~crc[15]) & bit) & crc[15])))))) | ((~crc[15] & (crc[15] | ((crc[15] | ~crc[15]) & bit))) & ~bit)))));
  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            crc <= 0;
          end
        else 
          begin
            if (en) 
              begin
                crc[15] <= crc[14];
                crc[14] <= crc[13];
                crc[13] <= crc[12];
                crc[12] <= ((~crc[11] & ((inv | crc[11]) & ~inv)) | (inv & ~crc[11])) | (((inv | crc[11]) & ~inv) & crc[11]);
                crc[11] <= crc[10];
                crc[10] <= crc[9];
                crc[9] <= crc[8];
                crc[8] <= crc[7];
                crc[7] <= crc[6];
                crc[6] <= crc[5];
                crc[5] <= ((~inv | (crc[4] | inv)) & crc[4]) ^ ((~inv | (crc[4] | inv)) & ((~crc[4] | crc[4]) & inv));
                crc[4] <= crc[3];
                crc[3] <= crc[2];
                crc[2] <= crc[1];
                crc[1] <= crc[0];
                crc[0] <= inv;
              end
              
          end
      end
endmodule

