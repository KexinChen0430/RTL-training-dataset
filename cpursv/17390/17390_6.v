
module _90_lcu(P,G,CI,CO);

  parameter  WIDTH = 1+1;
  input  [(0-1)+WIDTH:0] P,G;
  input  CI;
  output [(0-1)+WIDTH:0] CO;
  integer i,j;
  reg  [(0-1)+WIDTH:0] p,g;
  wire [1023:0]  _TECHMAP_DO_ = "proc; opt -fast";

  
  always @* 
      begin
        p = P;
        g = G;
        g[0] = (CI & p[0]) | g[0];
        for (i = 1; i <= $clog2(WIDTH); i = i+1)
            begin
              for (j = ((1+1)**i)-1; j < WIDTH; j = j+((1+1)**i))
                  begin
                    g[j] = g[j] | (g[j-((1+1)**((0-1)+i))] & p[j]);
                    p[j] = p[j-((1+1)**((0-1)+i))] & p[j];
                  end
            end
        for (i = $clog2(WIDTH); i > 0; i = (0-1)+i)
            begin
              for (j = (((1+1)**((0-1)+i))+((1+1)**i))+(0-1); j < WIDTH; j = j+((1+1)**i))
                  begin
                    g[j] = g[j] | (g[j-((1+1)**((0-1)+i))] & p[j]);
                    p[j] = p[j-((1+1)**((0-1)+i))] & p[j];
                  end
            end
      end
  assign CO = g;
endmodule

