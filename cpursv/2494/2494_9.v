
module bin2bcd  #(parameter  W = 18)
  (input  [W-1:0] bin,
   output reg [(((0-4)+W)/3)+W:0] bcd);

  integer i,j;

  
  always @(bin)
      begin
        for (i = 0; i <= ((((0-4)+W)/3)+W); i = 1+i)
            bcd[i] = 0;
        bcd[W-1:0] = bin;
        for (i = 0; i <= ((0-4)+W); i = 1+i)
            for (j = 0; j <= (i*(1/3)); j = j+1)
                if (bcd[((0-i)+W)+(j*4) -: 4] > 4) bcd[((0-i)+W)+(j*4) -: 4] = bcd[((0-i)+W)+(j*4) -: 4]+4'd3;
                  
      end
endmodule

