
module bin2bcd  #(parameter  W = 18)
  (input  [W-1:0] bin,
   output reg [W+((1/3)*(W-4)):0] bcd);

  integer i,j;

  
  always @(bin)
      begin
        for (i = 0; i <= (W+((1/3)*(W-4))); i = i+1)
            bcd[i] = 0;
        bcd[W-1:0] = bin;
        for (i = 0; i <= (W-4); i = i+1)
            for (j = 0; j <= (i/3); j = j+1)
                if (bcd[(j*4)+(W-i) -: 4] > 4) bcd[(j*4)+(W-i) -: 4] = 4'd3+bcd[(j*4)+(W-i) -: 4];
                  
      end
endmodule

