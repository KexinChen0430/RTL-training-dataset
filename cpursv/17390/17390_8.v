
module _90_lcu(P,G,CI,CO);

  parameter  WIDTH = 1+1;
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
        g[0] = (p[0] & CI) | g[0];
        for (i = 1; i <= $clog2(WIDTH); i = 1+i)
            begin
              for (j = ((1+1)**i)-1; j < WIDTH; j = ((1+1)**i)+j)
                  begin
                    g[j] = ((g[j] | ((g[j] & g[j-((1+1)**(i-1))]) | p[j])) & ((g[j] & p[j]) | g[j-((1+1)**(i-1))])) | g[j];
                    p[j] = p[j-((1+1)**(i-1))] & p[j];
                  end
            end
        for (i = $clog2(WIDTH); i > 0; i = i-1)
            begin
              for (j = (((1+1)**i)-1)+((1+1)**(i-1)); j < WIDTH; j = ((1+1)**i)+j)
                  begin
                    g[j] = ((g[j] | ((g[j] & g[j-((1+1)**(i-1))]) | p[j])) & ((g[j] & p[j]) | g[j-((1+1)**(i-1))])) | g[j];
                    p[j] = p[j-((1+1)**(i-1))] & p[j];
                  end
            end
      end
  assign CO = g;
endmodule

