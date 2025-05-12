
module bin2bcd  #(parameter  W = 18)
  (input  [W-1:0] bin,
   output reg [((1/3)*((-4)+W))+W:0] bcd);

  integer i,j;

  
  always @(bin)
      begin
        for (i = 0; i <= (((1/3)*((-4)+W))+W); i = 1+i)
            bcd[i] = 0;
        bcd[W-1:0] = bin;
        for (i = 0; i <= ((-4)+W); i = 1+i)
            for (j = 0; j <= (i*(1/3)); j = 1+j)
                if (bcd[W+((0-i)+(4*j)) -: 4] > 4) bcd[W+((0-i)+(4*j)) -: 4] = bcd[W+((0-i)+(4*j)) -: 4]+4'd3;
                  
      end
endmodule

