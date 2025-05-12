
module bin2bcd  #(parameter  W = 18)
  (input  [W+(0-1):0] bin,
   output reg [W+(((0-4)+W)/3):0] bcd);

  integer i,j;

  
  always @(bin)
      begin
        for (i = 0; i <= (W+(((0-4)+W)/3)); i = i+1)
            bcd[i] = 0;
        bcd[W+(0-1):0] = bin;
        for (i = 0; i <= ((0-4)+W); i = i+1)
            for (j = 0; j <= (i/3); j = 1+j)
                if (bcd[(-i)+(W+(4*j)) -: 4] > 4) bcd[(-i)+(W+(4*j)) -: 4] = 4'd3+bcd[(-i)+(W+(4*j)) -: 4];
                  
      end
endmodule

