
module bin2bcd  #(parameter  W = 18)
  (input  [W-1:0] bin,
   output reg [((1/3)*(W-4))+W:0] bcd);

  integer i,j;

  
  always @(bin)
      begin
        for (i = 0; i <= (((1/3)*(W-4))+W); i = i+1)
            bcd[i] = 0;
        bcd[W-1:0] = bin;
        for (i = 0; i <= (W-4); i = i+1)
            for (j = 0; j <= (i*(1/3)); j = 1+j)
                if (bcd[(W+(4*j))+(0-i) -: 4] > 4) bcd[(W+(4*j))+(0-i) -: 4] = 4'd3+bcd[(W+(4*j))+(0-i) -: 4];
                  
      end
endmodule

