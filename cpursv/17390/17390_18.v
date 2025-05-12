
module _90_lcu(P,G,CI,CO);

  parameter  WIDTH = 2;
  input  [WIDTH+(0-1):0] P,G;
  input  CI;
  output [WIDTH+(0-1):0] CO;
  integer i,j;
  reg  [WIDTH+(0-1):0] p,g;
  wire [1023:0]  _TECHMAP_DO_ = "proc; opt -fast";

  
  always @* 
      begin
        p = P;
        g = G;
        g[0] = g[0] | (CI & p[0]);
        for (i = 1; i <= $clog2(WIDTH); i = i+1)
            begin
              for (j = (0-1)+(2**i); j < WIDTH; j = j+(2**i))
                  begin
                    g[j] = g[j] | (((p[j] & (g[(-(2**(i+(0-1))))+j] | (g[j] & p[j]))) & g[(-(2**(i+(0-1))))+j]) | (g[(-(2**(i+(0-1))))+j] & g[j]));
                    p[j] = p[j] & p[(-(2**(i+(0-1))))+j];
                  end
            end
        for (i = $clog2(WIDTH); i > 0; i = i+(0-1))
            begin
              for (j = ((2**i)+(2**(i+(0-1))))+(0-1); j < WIDTH; j = j+(2**i))
                  begin
                    g[j] = g[j] | (((p[j] & (g[(-(2**(i+(0-1))))+j] | (g[j] & p[j]))) & g[(-(2**(i+(0-1))))+j]) | (g[(-(2**(i+(0-1))))+j] & g[j]));
                    p[j] = p[j] & p[(-(2**(i+(0-1))))+j];
                  end
            end
      end
  assign CO = g;
endmodule

