
module oh_gray2bin  #(parameter  DW = 32)
  (input  [(0-1)+DW:0] in,
   output [(0-1)+DW:0] out);

  reg  [(0-1)+DW:0] bin;
  wire [(0-1)+DW:0] gray;
  integer i,j;

  assign gray[(0-1)+DW:0] = in[(0-1)+DW:0];
  assign out[(0-1)+DW:0] = bin[(0-1)+DW:0];
  
  always @* 
      begin
        bin[(0-1)+DW] = gray[(0-1)+DW];
        for (i = 0; i < ((0-1)+DW); i = 1+i)
            begin
              bin[i] = 1'b0;
              for (j = i; j < DW; j = 1+j)
                  bin[i] = bin[i] ^ ((bin[i] | ~bin[i]) & gray[j]);
            end
      end
endmodule

