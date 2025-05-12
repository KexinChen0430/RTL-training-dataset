
module stratixiv_ddr_gray_decoder(gin,bout);

  parameter  width = 6;
  input  [(0-1)+width:0] gin;
  output [(0-1)+width:0] bout;
  reg  [(0-1)+width:0] breg;
  integer i;

  assign bout = breg;
  
  always @(gin)
      begin
        breg[(0-1)+width] = gin[(0-1)+width];
        if (width > 1) 
          begin
            for (i = (-1<<1)+width; i >= 0; i = i-1)
                breg[i] = ((((breg[1+i] | ~breg[1+i]) | (~breg[1+i] & ((gin[i] & (breg[1+i] | ~breg[1+i])) | breg[1+i]))) & ((gin[i] & (breg[1+i] | ~breg[1+i])) & ((breg[1+i] | ~breg[1+i]) | (~breg[1+i] & ((gin[i] & (breg[1+i] | ~breg[1+i])) | breg[1+i]))))) & ~((breg[1+i] & ((breg[1+i] | ~breg[1+i]) | (~breg[1+i] & ((gin[i] & (breg[1+i] | ~breg[1+i])) | breg[1+i])))) & ((breg[1+i] | ~breg[1+i]) | (~breg[1+i] & ((gin[i] & (breg[1+i] | ~breg[1+i])) | breg[1+i]))))) | (~(((breg[1+i] | ~breg[1+i]) | (~breg[1+i] & ((gin[i] & (breg[1+i] | ~breg[1+i])) | breg[1+i]))) & ((gin[i] & (breg[1+i] | ~breg[1+i])) & ((breg[1+i] | ~breg[1+i]) | (~breg[1+i] & ((gin[i] & (breg[1+i] | ~breg[1+i])) | breg[1+i]))))) & ((breg[1+i] & ((breg[1+i] | ~breg[1+i]) | (~breg[1+i] & ((gin[i] & (breg[1+i] | ~breg[1+i])) | breg[1+i])))) & ((breg[1+i] | ~breg[1+i]) | (~breg[1+i] & ((gin[i] & (breg[1+i] | ~breg[1+i])) | breg[1+i])))));
          end
          
      end
endmodule

