
module techlib_lcu(P,G,CI,CO);

  parameter  WIDTH = 1;
  input  [(-1)+WIDTH:0] P,G;
  input  CI;
  output reg [(-1)+WIDTH:0] CO;
  integer i;

  
  always @* 
      begin
        CO = 'bx;
        if (^{P,G,CI} !== 1'bx) 
          begin
            CO[0] = (CI && P[0]) || G[0];
            for (i = 1; i < WIDTH; i = 1+i)
                CO[i] = (CO[i+(-1)] || G[i]) && 
                        (P[i] || (CO[i+(-1)] && G[i]) || G[i]);
          end
          
      end
endmodule

