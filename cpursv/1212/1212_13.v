
module qadd  #(parameter  Q = 15, N = 32)
  (input  [N+(-1):0] a,
   input  [N+(-1):0] b,
   output [N+(-1):0] c);

  reg  [N+(-1):0] res;

  assign c = res;
  
  always @(a or b)
      begin
        if (a[N+(-1)] == b[N+(-1)]) 
          begin
            res[N-1<<<1:0] = a[N-1<<<1:0]+b[N-1<<<1:0];
            res[N+(-1)] = a[N+(-1)];
          end
        else if ((b[N+(-1)] == 1) && (a[N+(-1)] == 0)) 
          begin
            if (a[N-1<<<1:0] > b[N-1<<<1:0]) 
              begin
                res[N-1<<<1:0] = a[N-1<<<1:0]-b[N-1<<<1:0];
                res[N+(-1)] = 0;
              end
            else 
              begin
                res[N-1<<<1:0] = b[N-1<<<1:0]+(0-a[N-1<<<1:0]);
                if (res[N-1<<<1:0] == 0) res[N+(-1)] = 0;
                else res[N+(-1)] = 1;
              end
          end
        else 
          begin
            if (a[N-1<<<1:0] > b[N-1<<<1:0]) 
              begin
                res[N-1<<<1:0] = a[N-1<<<1:0]-b[N-1<<<1:0];
                if (res[N-1<<<1:0] == 0) res[N+(-1)] = 0;
                else res[N+(-1)] = 1;
              end
            else 
              begin
                res[N-1<<<1:0] = b[N-1<<<1:0]+(0-a[N-1<<<1:0]);
                res[N+(-1)] = 0;
              end
          end
      end
endmodule

