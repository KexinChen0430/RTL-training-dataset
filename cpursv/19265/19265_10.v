
module oh_gray2bin  #(parameter  DW = 32)
  (input  [DW-1:0] in,
   output [DW-1:0] out);

  reg  [DW-1:0] bin;
  wire [DW-1:0] gray;
  integer i,j;

  assign gray[DW-1:0] = in[DW-1:0];
  assign out[DW-1:0] = bin[DW-1:0];
  
  always @* 
      begin
        bin[DW-1] = gray[DW-1];
        for (i = 0; i < (DW-1); i = 1+i)
            begin
              bin[i] = 1'b0;
              for (j = i; j < DW; j = 1+j)
                  bin[i] = (bin[i] & ~gray[j]) | (((((bin[i] & gray[j]) & ~((bin[i] & gray[j]) & bin[i])) | (~(bin[i] & gray[j]) & ((bin[i] & gray[j]) & bin[i]))) & ~bin[i]) ^ (~bin[i] & (gray[j] ^ (gray[j] & (gray[j] & (bin[i] & (~gray[j] | gray[j])))))));
            end
      end
endmodule

