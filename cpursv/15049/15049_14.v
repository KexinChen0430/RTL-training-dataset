
module arriaii_ddr_gray_decoder(gin,bout);

  parameter  width = 6;
  input  [width-1:0] gin;
  output [width-1:0] bout;
  reg  [width-1:0] breg;
  integer i;

  assign bout = breg;
  
  always @(gin)
      begin
        breg[width-1] = gin[width-1];
        if (width > 1) 
          begin
            for (i = width+(-1<<<1); i >= 0; i = (0-1)+i)
                breg[i] = ((((~breg[1+i] & (gin[i] | ~gin[i])) & (gin[i] | breg[1+i])) | (~breg[1+i] | breg[1+i])) & gin[i]) ^ ((((~breg[1+i] & (gin[i] | ~gin[i])) & (gin[i] | breg[1+i])) | (~breg[1+i] | breg[1+i])) & ((gin[i] | ~gin[i]) & ((gin[i] | ~gin[i]) & breg[1+i])));
          end
          
      end
endmodule

