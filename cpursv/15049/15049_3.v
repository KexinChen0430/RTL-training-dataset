
module arriaii_ddr_gray_decoder(gin,bout);

  parameter  width = 6;
  input  [width+(0-1):0] gin;
  output [width+(0-1):0] bout;
  reg  [width+(0-1):0] breg;
  integer i;

  assign bout = breg;
  
  always @(gin)
      begin
        breg[width+(0-1)] = gin[width+(0-1)];
        if (width > 1) 
          begin
            for (i = (0-1<<<1)+width; i >= 0; i = i+(0-1))
                breg[i] = (~gin[i] & (((~gin[i] | gin[i]) & breg[i+1]) & (~gin[i] | gin[i]))) | (gin[i] & ~(((~gin[i] | gin[i]) & breg[i+1]) & (~gin[i] | gin[i])));
          end
          
      end
endmodule

