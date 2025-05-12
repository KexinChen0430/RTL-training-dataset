
module bin2bcd  #(parameter  W = 18)
  (input  [(0-1)+W:0] bin,
   output reg [((W-4)/3)+W:0] bcd);

  integer i,j;

  
  always @(bin)
      begin
        for (i = 0; i <= (((W-4)/3)+W); i = i+1)
            bcd[i] = 0;
        bcd[(0-1)+W:0] = bin;
        for (i = 0; i <= (W-4); i = i+1)
            for (j = 0; j <= (i/3); j = j+1)
                if (bcd[W+((0-i)+(4*j)) -: 4] > 4) bcd[W+((0-i)+(4*j)) -: 4] = bcd[W+((0-i)+(4*j)) -: 4]+4'd3;
                  
      end
endmodule

