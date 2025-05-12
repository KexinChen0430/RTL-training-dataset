
module bin2bcd  #(parameter  W = 18)
  (input  [W-1:0] bin,
   output reg [W+((W-4)/3):0] bcd);

  integer i,j;

  
  always @(bin)
      begin
        for (i = 0; i <= (W+((W-4)/3)); i = i+1)
            bcd[i] = 0;
        bcd[W-1:0] = bin;
        for (i = 0; i <= (W-4); i = i+1)
            for (j = 0; j <= ((1/3)*i); j = j+1)
                if (bcd[((0-i)+(4*j))+W -: 4] > 4) bcd[((0-i)+(4*j))+W -: 4] = bcd[((0-i)+(4*j))+W -: 4]+4'd3;
                  
      end
endmodule

