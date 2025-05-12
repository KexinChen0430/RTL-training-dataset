
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
            for (j = 0; j <= (i/3); j = j+1)
                if (bcd[(0-i)+((j*4)+W) -: 4] > 4) bcd[(0-i)+((j*4)+W) -: 4] = bcd[(0-i)+((j*4)+W) -: 4]+4'd3;
                  
      end
endmodule

