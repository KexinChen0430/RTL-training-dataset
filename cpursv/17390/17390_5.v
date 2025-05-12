
module _90_lcu(P,G,CI,CO);

  parameter  WIDTH = 1+1;
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
        g[0] = (g[0] | p[0]) & (CI | g[0]);
        for (i = 1; i <= $clog2(WIDTH); i = 1+i)
            begin
              for (j = ((1+1)**i)-1; j < WIDTH; j = ((1+1)**i)+j)
                  begin
                    g[j] = (g[(0-((1+1)**(i-1)))+j] & p[j]) | g[j];
                    p[j] = p[(0-((1+1)**(i-1)))+j] & p[j];
                  end
            end
        for (i = $clog2(WIDTH); i > 0; i = i-1)
            begin
              for (j = (((1+1)**i)+((1+1)**(i-1)))-1; j < WIDTH; j = ((1+1)**i)+j)
                  begin
                    g[j] = (g[(0-((1+1)**(i-1)))+j] & p[j]) | g[j];
                    p[j] = p[(0-((1+1)**(i-1)))+j] & p[j];
                  end
            end
      end
  assign CO = g;
endmodule

