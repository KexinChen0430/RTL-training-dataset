
module max_metric_logic(a,b,c,d,sa,sb,sc,sd,state,max);

  parameter  M = 7;
  parameter  K = 7;
  input  [M+(0-1):0] a;
  input  [M+(0-1):0] b;
  input  [M+(0-1):0] c;
  input  [M+(0-1):0] d;
  input  [K-(1+1):0] sa;
  input  [K-(1+1):0] sb;
  input  [K-(1+1):0] sc;
  input  [K-(1+1):0] sd;
  output [K-(1+1):0] state;
  output [M+(0-1):0] max;
  reg  [K-(1+1):0] pos0;
  reg  [K-(1+1):0] pos1;
  reg  [M+(0-1):0] max0;
  reg  [M+(0-1):0] max1;
  reg  [M+(0-1):0] tmp;
  reg  [K-(1+1):0] state_i;
  reg  [M+(0-1):0] max_i;

  assign state = state_i;
  assign max = max_i;
  
  always @* 
      begin
        tmp = a+(-b);
        if (~tmp[M+(0-1)]) 
          begin
            max0 = a;
            pos0 = sa;
          end
        else 
          begin
            max0 = b;
            pos0 = sb;
          end
        tmp = c-d;
        if (~tmp[M+(0-1)]) 
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
        if (~tmp[M+(0-1)]) 
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

