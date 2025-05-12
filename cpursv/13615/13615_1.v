
module stratixiii_ddr_gray_decoder(gin,bout);

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
            for (i = width+(0-1<<1); i >= 0; i = i-1)
                breg[i] = (~(((~breg[i+1] | breg[i+1]) & (gin[i] & (~breg[i+1] | breg[i+1]))) & (gin[i] | ~gin[i])) & (breg[i+1] & (gin[i] | ~gin[i]))) | ((((~breg[i+1] | breg[i+1]) & (gin[i] & (~breg[i+1] | breg[i+1]))) & (gin[i] | ~gin[i])) & ~(breg[i+1] & (gin[i] | ~gin[i])));
          end
          
      end
endmodule

