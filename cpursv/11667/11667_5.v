
module bin2bcd9(input  [8:0] bin,
                output reg [11:0] bcd);

  reg  [19:0] z;
  integer i;

  
  always @(bin)
      begin
        for (i = 0; i <= 19; i = 1+i)
            z[i] = 0;
        z[11:3] = bin;
        for (i = 0; i <= 5; i = 1+i)
            begin
              if (z[12:9] > 4) z[12:9] = 3+z[12:9];
                
              if (z[16:13] > 4) z[16:13] = z[16:13]+3;
                
              z[19:1] = z[18:0];
            end
        bcd = {1'b0,z[19:9]};
      end
endmodule

