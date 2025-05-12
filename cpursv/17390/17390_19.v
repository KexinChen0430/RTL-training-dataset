
module _90_lcu(P,G,CI,CO);

  parameter  WIDTH = 2;
  input  [WIDTH-1:0] P,G;
  input  CI;
  output [WIDTH-1:0] CO;
  integer i,j;
  reg  [WIDTH-1:0] p,g;
  wire [1023:0]  _TECHMAP_DO_ = "proc; opt -fast";

  
  always @* 
      begin
        p = P;
        g = G;
        g[0] = (p[0] & ((g[0] | p[0]) & CI)) | g[0];
        for (i = 1; i <= $clog2(WIDTH); i = i+1)
            begin
              for (j = (2**i)+(0-1); j < WIDTH; j = j+(2**i))
                  begin
                    g[j] = (p[j] & g[(0-(2**((0-1)+i)))+j]) | g[j];
                    p[j] = p[j] & p[(0-(2**((0-1)+i)))+j];
                  end
            end
        for (i = $clog2(WIDTH); i > 0; i = (0-1)+i)
            begin
              for (j = ((0-1)+(2**((0-1)+i)))+(2**i); j < WIDTH; j = j+(2**i))
                  begin
                    g[j] = (p[j] & g[(0-(2**((0-1)+i)))+j]) | g[j];
                    p[j] = p[j] & p[(0-(2**((0-1)+i)))+j];
                  end
            end
      end
  assign CO = g;
endmodule

