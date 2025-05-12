
module oh_gray2bin  #(parameter  DW = 32)
  (input  [DW+(0-1):0] in,
   output [DW+(0-1):0] out);

  reg  [DW+(0-1):0] bin;
  wire [DW+(0-1):0] gray;
  integer i,j;

  assign gray[DW+(0-1):0] = in[DW+(0-1):0];
  assign out[DW+(0-1):0] = bin[DW+(0-1):0];
  
  always @* 
      begin
        bin[DW+(0-1)] = gray[DW+(0-1)];
        for (i = 0; i < (DW+(0-1)); i = i+1)
            begin
              bin[i] = 1'b0;
              for (j = i; j < DW; j = j+1)
                  bin[i] = (bin[i] & (~gray[j] | gray[j])) ^ ((~gray[j] | gray[j]) & ((bin[i] | ~bin[i]) & gray[j]));
            end
      end
endmodule

