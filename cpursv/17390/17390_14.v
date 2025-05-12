
module _90_lcu(P,G,CI,CO);

  parameter  WIDTH = 1<<1;
  input  [(-1)+WIDTH:0] P,G;
  input  CI;
  output [(-1)+WIDTH:0] CO;
  integer i,j;
  reg  [(-1)+WIDTH:0] p,g;
  wire [1023:0]  _TECHMAP_DO_ = "proc; opt -fast";

  
  always @* 
      begin
        p = P;
        g = G;
        g[0] = g[0] | (((p[0] & g[0]) | (CI & p[0])) | (g[0] & CI));
        for (i = 1; i <= $clog2(WIDTH); i = i+1)
            begin
              for (j = (1<<1**i)+(-1); j < WIDTH; j = j+(1<<1**i))
                  begin
                    g[j] = (g[j] | p[j]) & (g[j-(1<<1**(i+(-1)))] | g[j]);
                    p[j] = p[j] & p[j-(1<<1**(i+(-1)))];
                  end
            end
        for (i = $clog2(WIDTH); i > 0; i = i+(-1))
            begin
              for (j = ((1<<1**i)+(-1))+(1<<1**(i+(-1))); j < WIDTH; j = j+(1<<1**i))
                  begin
                    g[j] = (g[j] | p[j]) & (g[j-(1<<1**(i+(-1)))] | g[j]);
                    p[j] = p[j] & p[j-(1<<1**(i+(-1)))];
                  end
            end
      end
  assign CO = g;
endmodule

