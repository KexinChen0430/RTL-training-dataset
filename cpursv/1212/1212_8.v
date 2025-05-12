
module qadd  #(parameter  Q = 15, N = 32)
  (input  [N+(0-1):0] a,
   input  [N+(0-1):0] b,
   output [N+(0-1):0] c);

  reg  [N+(0-1):0] res;

  assign c = res;
  
  always @(a or b)
      begin
        if (a[N+(0-1)] == b[N+(0-1)]) 
          begin
            res[N-(1+1):0] = b[N-(1+1):0]+a[N-(1+1):0];
            res[N+(0-1)] = a[N+(0-1)];
          end
        else if ((a[N+(0-1)] == 0) && (b[N+(0-1)] == 1)) 
          begin
            if (a[N-(1+1):0] > b[N-(1+1):0]) 
              begin
                res[N-(1+1):0] = (0-b[N-(1+1):0])+a[N-(1+1):0];
                res[N+(0-1)] = 0;
              end
            else 
              begin
                res[N-(1+1):0] = b[N-(1+1):0]+(-a[N-(1+1):0]);
                if (res[N-(1+1):0] == 0) res[N+(0-1)] = 0;
                else res[N+(0-1)] = 1;
              end
          end
        else 
          begin
            if (a[N-(1+1):0] > b[N-(1+1):0]) 
              begin
                res[N-(1+1):0] = (0-b[N-(1+1):0])+a[N-(1+1):0];
                if (res[N-(1+1):0] == 0) res[N+(0-1)] = 0;
                else res[N+(0-1)] = 1;
              end
            else 
              begin
                res[N-(1+1):0] = b[N-(1+1):0]+(-a[N-(1+1):0]);
                res[N+(0-1)] = 0;
              end
          end
      end
endmodule

