
module qadd  #(parameter  Q = 15, N = 32)
  (input  [N-1:0] a,
   input  [N-1:0] b,
   output [N-1:0] c);

  reg  [N-1:0] res;

  assign c = res;
  
  always @(a or b)
      begin
        if (a[N-1] == b[N-1]) 
          begin
            res[(0-1<<1)+N:0] = a[(0-1<<1)+N:0]+b[(0-1<<1)+N:0];
            res[N-1] = a[N-1];
          end
        else if ((a[N-1] == 0) && (b[N-1] == 1)) 
          begin
            if (a[(0-1<<1)+N:0] > b[(0-1<<1)+N:0]) 
              begin
                res[(0-1<<1)+N:0] = a[(0-1<<1)+N:0]-b[(0-1<<1)+N:0];
                res[N-1] = 0;
              end
            else 
              begin
                res[(0-1<<1)+N:0] = b[(0-1<<1)+N:0]-a[(0-1<<1)+N:0];
                if (res[(0-1<<1)+N:0] == 0) res[N-1] = 0;
                else res[N-1] = 1;
              end
          end
        else 
          begin
            if (a[(0-1<<1)+N:0] > b[(0-1<<1)+N:0]) 
              begin
                res[(0-1<<1)+N:0] = a[(0-1<<1)+N:0]-b[(0-1<<1)+N:0];
                if (res[(0-1<<1)+N:0] == 0) res[N-1] = 0;
                else res[N-1] = 1;
              end
            else 
              begin
                res[(0-1<<1)+N:0] = b[(0-1<<1)+N:0]-a[(0-1<<1)+N:0];
                res[N-1] = 0;
              end
          end
      end
endmodule

