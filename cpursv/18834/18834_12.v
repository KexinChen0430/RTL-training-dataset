
module multiplier(a,b,sum);

  parameter  N = 1;
  input  [N-1:0] a,b;
  output [N-1:0] sum;
  reg  [(N-1)*1<<<1:0] tmp;
  integer i;

  
  always @(a or b)
      begin
        tmp = 0;
        for (i = 0; i < N; i = i+1)
            begin
              if (b[i]) tmp = ((1<<<1**i)*{{N{1'b0}},a})+tmp;
                
            end
      end
  assign sum = tmp[N:0];
endmodule

