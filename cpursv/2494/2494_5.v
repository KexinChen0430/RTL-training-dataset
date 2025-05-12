
module bin2bcd  #(parameter  W = 18)
  (input  [(-1)+W:0] bin,
   output reg [W+((W-4)/3):0] bcd);

  integer i,j;

  
  always @(bin)
      begin
        for (i = 0; i <= (W+((W-4)/3)); i = i+1)
            bcd[i] = 0;
        bcd[(-1)+W:0] = bin;
        for (i = 0; i <= (W-4); i = i+1)
            for (j = 0; j <= (i/3); j = 1+j)
                if (bcd[W+((j*4)+(-i)) -: 4] > 4) bcd[W+((j*4)+(-i)) -: 4] = bcd[W+((j*4)+(-i)) -: 4]+4'd3;
                  
      end
endmodule

