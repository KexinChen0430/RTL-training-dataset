
module oh_gray2bin  #(parameter  DW = 32)
  (input  [(-1)+DW:0] in,
   output [(-1)+DW:0] out);

  reg  [(-1)+DW:0] bin;
  wire [(-1)+DW:0] gray;
  integer i,j;

  assign gray[(-1)+DW:0] = in[(-1)+DW:0];
  assign out[(-1)+DW:0] = bin[(-1)+DW:0];
  
  always @* 
      begin
        bin[(-1)+DW] = gray[(-1)+DW];
        for (i = 0; i < ((-1)+DW); i = 1+i)
            begin
              bin[i] = 1'b0;
              for (j = i; j < DW; j = 1+j)
                  bin[i] = ((gray[j] | bin[i]) & ~gray[j]) | (gray[j] & ~bin[i]);
            end
      end
endmodule

