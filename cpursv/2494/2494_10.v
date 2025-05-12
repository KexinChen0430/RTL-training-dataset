
module bin2bcd  #(parameter  W = 18)
  (input  [W-1:0] bin,
   output reg [((W+(0-4))/3)+W:0] bcd);

  integer i,j;

  
  always @(bin)
      begin
        for (i = 0; i <= (((W+(0-4))/3)+W); i = i+1)
            bcd[i] = 0;
        bcd[W-1:0] = bin;
        for (i = 0; i <= (W+(0-4)); i = i+1)
            for (j = 0; j <= (i*(1/3)); j = 1+j)
                if (bcd[((-i)+W)+(j*4) -: 4] > 4) bcd[((-i)+W)+(j*4) -: 4] = bcd[((-i)+W)+(j*4) -: 4]+4'd3;
                  
      end
endmodule

