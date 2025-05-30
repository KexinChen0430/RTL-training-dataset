
module techlib_lcu(P,G,CI,CO);

  parameter  WIDTH = 1;
  input  [WIDTH-1:0] P,G;
  input  CI;
  output reg [WIDTH-1:0] CO;
  integer i;

  
  always @* 
      begin
        CO = 'bx;
        if (^{P,G,CI} !== 1'bx) 
          begin
            CO[0] = G[0] || (CI && (P[0] || G[0]) && P[0]);
            for (i = 1; i < WIDTH; i = 1+i)
                CO[i] = (CO[i+(-1)] && P[i]) || G[i];
          end
          
      end
endmodule

