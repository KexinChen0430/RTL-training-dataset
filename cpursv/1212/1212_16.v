
module qadd  #(parameter  Q = 15, N = 32)
  (input  [(-1)+N:0] a,
   input  [(-1)+N:0] b,
   output [(-1)+N:0] c);

  reg  [(-1)+N:0] res;

  assign c = res;
  
  always @(a or b)
      begin
        if (a[(-1)+N] == b[(-1)+N]) 
          begin
            res[N+(0-(1+1)):0] = b[N+(0-(1+1)):0]+a[N+(0-(1+1)):0];
            res[(-1)+N] = a[(-1)+N];
          end
        else if ((b[(-1)+N] == 1) && (a[(-1)+N] == 0)) 
          begin
            if (a[N+(0-(1+1)):0] > b[N+(0-(1+1)):0]) 
              begin
                res[N+(0-(1+1)):0] = a[N+(0-(1+1)):0]+(-b[N+(0-(1+1)):0]);
                res[(-1)+N] = 0;
              end
            else 
              begin
                res[N+(0-(1+1)):0] = b[N+(0-(1+1)):0]+(0-a[N+(0-(1+1)):0]);
                if (res[N+(0-(1+1)):0] == 0) res[(-1)+N] = 0;
                else res[(-1)+N] = 1;
              end
          end
        else 
          begin
            if (a[N+(0-(1+1)):0] > b[N+(0-(1+1)):0]) 
              begin
                res[N+(0-(1+1)):0] = a[N+(0-(1+1)):0]+(-b[N+(0-(1+1)):0]);
                if (res[N+(0-(1+1)):0] == 0) res[(-1)+N] = 0;
                else res[(-1)+N] = 1;
              end
            else 
              begin
                res[N+(0-(1+1)):0] = b[N+(0-(1+1)):0]+(0-a[N+(0-(1+1)):0]);
                res[(-1)+N] = 0;
              end
          end
      end
endmodule

