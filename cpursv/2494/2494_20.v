
module bin2bcd  #(parameter  W = 18)
  (input  [W+(0-1):0] bin,
   output reg [W+((W-4)*(1/3)):0] bcd);

  integer i,j;

  
  always @(bin)
      begin
        for (i = 0; i <= (W+((W-4)*(1/3))); i = i+1)
            bcd[i] = 0;
        bcd[W+(0-1):0] = bin;
        for (i = 0; i <= (W-4); i = i+1)
            for (j = 0; j <= (i/3); j = j+1)
                if (bcd[(j*4)+(W+(0-i)) -: 4] > 4) bcd[(j*4)+(W+(0-i)) -: 4] = bcd[(j*4)+(W+(0-i)) -: 4]+4'd3;
                  
      end
endmodule

