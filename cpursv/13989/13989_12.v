
module hardcopyiv_ddr_gray_decoder(gin,bout);

  parameter  width = 6;
  input  [(-1)+width:0] gin;
  output [(-1)+width:0] bout;
  reg  [(-1)+width:0] breg;
  integer i;

  assign bout = breg;
  
  always @(gin)
      begin
        breg[(-1)+width] = gin[(-1)+width];
        if (width > 1) 
          begin
            for (i = (0-1<<<1)+width; i >= 0; i = (-1)+i)
                breg[i] = (gin[i] & ~((breg[1+i] & (~gin[i] | (gin[i] | breg[1+i]))) & (~gin[i] | (gin[i] | breg[1+i])))) | (~gin[i] & ((breg[1+i] & (~gin[i] | (gin[i] | breg[1+i]))) & (~gin[i] | (gin[i] | breg[1+i]))));
          end
          
      end
endmodule

