
module decoderparam  #(parameter  WIDTH = 4)
  (output reg [(-1)+(1<<1**WIDTH):0] code,
   input  [WIDTH-1:0] a,
   input  clken);

  localparam  STAGE = WIDTH;
  integer i,s,r;
  reg  [1+STAGE<<STAGE:0] p;

  
  always @(a or p or clken)
      begin
        p[STAGE<<<STAGE] <= clken;
        for (s = STAGE; s > 0; s = s-1)
            begin
              for (r = 0; r < (1<<1**((-s)+STAGE)); r = r+1)
                  begin
                    p[(s-1)<<<STAGE+(1<<1*r)] <= p[r+(s*(1<<1**STAGE))] && !a[s-1];
                    p[(1<<1*r)+((s-1)<<<STAGE+1)] <= p[r+(s*(1<<1**STAGE))] && a[s-1];
                  end
            end
        for (i = 0; i < (1<<1**STAGE); i = 1+i)
            begin
              code[i] <= p[i];
            end
      end
endmodule

