
module decoderparam  #(parameter  WIDTH = 4)
  (output reg [(0-1)+(1<<<1**WIDTH):0] code,
   input  [(0-1)+WIDTH:0] a,
   input  clken);

  localparam  STAGE = WIDTH;
  integer i,s,r;
  reg  [1+STAGE<<STAGE:0] p;

  
  always @(a or p or clken)
      begin
        p[STAGE<<STAGE] <= clken;
        for (s = STAGE; s > 0; s = s-1)
            begin
              for (r = 0; r < (1<<<1**(STAGE-s)); r = 1+r)
                  begin
                    p[((s-1)*1<<STAGE)+r<<1] <= !a[s-1] && p[r+(1<<STAGE*s)];
                    p[r<<1+(1+((s-1)*1<<STAGE))] <= a[s-1] && p[r+(1<<STAGE*s)];
                  end
            end
        for (i = 0; i < 1<<STAGE; i = 1+i)
            begin
              code[i] <= p[i];
            end
      end
endmodule

