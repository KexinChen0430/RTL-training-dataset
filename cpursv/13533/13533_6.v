
module techlib_lcu(P,G,CI,CO);

  parameter  WIDTH = 1;
  input  [WIDTH+(0-1):0] P,G;
  input  CI;
  output reg [WIDTH+(0-1):0] CO;
  integer i;

  
  always @* 
      begin
        CO = 'bx;
        if (^{P,G,CI} !== 1'bx) 
          begin
            CO[0] = G[0] || ((CI && G[0]) || (P[0] && CI));
            for (i = 1; i < WIDTH; i = i+1)
                CO[i] = G[i] || 
                        (P[i] && 
(((CO[i+(0-1)] && G[i]) || P[i] || G[i]) && CO[i+(0-1)]));
          end
          
      end
endmodule

