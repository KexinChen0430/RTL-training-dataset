
module bin2bcd  #(parameter  W = 18)
  (input  [W+(-1):0] bin,
   output reg [((1/3)*(W-4))+W:0] bcd);

  integer i,j;

  
  always @(bin)
      begin
        for (i = 0; i <= (((1/3)*(W-4))+W); i = 1+i)
            bcd[i] = 0;
        bcd[W+(-1):0] = bin;
        for (i = 0; i <= (W-4); i = 1+i)
            for (j = 0; j <= ((1/3)*i); j = 1+j)
                if (bcd[(0-i)+((4*j)+W) -: 4] > 4) bcd[(0-i)+((4*j)+W) -: 4] = 4'd3+bcd[(0-i)+((4*j)+W) -: 4];
                  
      end
endmodule

