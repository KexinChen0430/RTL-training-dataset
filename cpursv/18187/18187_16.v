
module max_metric_logic(a,b,c,d,sa,sb,sc,sd,state,max);

  parameter  M = 7;
  parameter  K = 7;
  input  [(0-1)+M:0] a;
  input  [(0-1)+M:0] b;
  input  [(0-1)+M:0] c;
  input  [(0-1)+M:0] d;
  input  [(-(1+1))+K:0] sa;
  input  [(-(1+1))+K:0] sb;
  input  [(-(1+1))+K:0] sc;
  input  [(-(1+1))+K:0] sd;
  output [(-(1+1))+K:0] state;
  output [(0-1)+M:0] max;
  reg  [(-(1+1))+K:0] pos0;
  reg  [(-(1+1))+K:0] pos1;
  reg  [(0-1)+M:0] max0;
  reg  [(0-1)+M:0] max1;
  reg  [(0-1)+M:0] tmp;
  reg  [(-(1+1))+K:0] state_i;
  reg  [(0-1)+M:0] max_i;

  assign state = state_i;
  assign max = max_i;
  
  always @* 
      begin
        tmp = a+(-b);
        if (~tmp[(0-1)+M]) 
          begin
            max0 = a;
            pos0 = sa;
          end
        else 
          begin
            max0 = b;
            pos0 = sb;
          end
        tmp = (0-d)+c;
        if (~tmp[(0-1)+M]) 
          begin
            max1 = c;
            pos1 = sc;
          end
        else 
          begin
            max1 = d;
            pos1 = sd;
          end
        tmp = max0-max1;
        if (~tmp[(0-1)+M]) 
          begin
            max_i = max0;
            state_i = pos0;
          end
        else 
          begin
            state_i = pos1;
            max_i = max1;
          end
      end
endmodule

