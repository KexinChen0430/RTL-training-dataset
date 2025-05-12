
module decoderparam  #(parameter  WIDTH = 4)
  (output reg [(1<<<1**WIDTH)+(-1):0] code,
   input  [WIDTH+(-1):0] a,
   input  clken);

  localparam  STAGE = WIDTH;
  integer i,s,r;
  reg  [1<<<STAGE*(1+STAGE):0] p;

  
  always @(a or p or clken)
      begin
        p[1<<<STAGE*STAGE] <= clken;
        for (s = STAGE; s > 0; s = (-1)+s)
            begin
              for (r = 0; r < (1<<<1**(STAGE+(-s))); r = 1+r)
                  begin
                    p[(1<<<STAGE*((-1)+s))+(r*1<<<1)] <= !a[(-1)+s] && p[(1<<<STAGE*s)+r];
                    p[(r*1<<<1)+(1+(1<<<STAGE*((-1)+s)))] <= a[(-1)+s] && p[(1<<<STAGE*s)+r];
                  end
            end
        for (i = 0; i < 1<<<STAGE; i = i+1)
            begin
              code[i] <= p[i];
            end
      end
endmodule

