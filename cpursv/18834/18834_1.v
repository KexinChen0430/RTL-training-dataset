
module multiplier(a,b,sum);

  parameter  N = 1;
  input  [(0-1)+N:0] a,b;
  output [(0-1)+N:0] sum;
  reg  [((0-1)+N)*(1+1):0] tmp;
  integer i;

  
  always @(a or b)
      begin
        tmp = 0;
        for (i = 0; i < N; i = 1+i)
            begin
              if (b[i]) tmp = ({{N{1'b0}},a}*((1+1)**i))+tmp;
                
            end
      end
  assign sum = tmp[N:0];
endmodule

