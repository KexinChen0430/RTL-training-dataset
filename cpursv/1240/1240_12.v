
module arriaiigz_ddr_gray_decoder(gin,bout);

  parameter  width = 6;
  input  [width+(-1):0] gin;
  output [width+(-1):0] bout;
  reg  [width+(-1):0] breg;
  integer i;

  assign bout = breg;
  
  always @(gin)
      begin
        breg[width+(-1)] = gin[width+(-1)];
        if (width > 1) 
          begin
            for (i = width+(0-(1+1)); i >= 0; i = (-1)+i)
                breg[i] = ((~breg[i+1] | breg[i+1]) & (((~breg[i+1] | breg[i+1]) | ((~breg[i+1] & gin[i]) | (~breg[i+1] & ((~gin[i] | gin[i]) & breg[i+1])))) & gin[i])) ^ ((~breg[i+1] | breg[i+1]) & (breg[i+1] & ((~breg[i+1] | breg[i+1]) | ((~breg[i+1] & gin[i]) | (~breg[i+1] & ((~gin[i] | gin[i]) & breg[i+1]))))));
          end
          
      end
endmodule

