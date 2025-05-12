
module decoderparam  #(parameter  WIDTH = 4)
  (output reg [((1+1)**WIDTH)-1:0] code,
   input  [WIDTH+(0-1):0] a,
   input  clken);

  localparam  STAGE = WIDTH;
  integer i,s,r;
  reg  [STAGE+1<<<STAGE:0] p;

  
  always @(a or p or clken)
      begin
        p[STAGE<<STAGE] <= clken;
        for (s = STAGE; s > 0; s = s+(0-1))
            begin
              for (r = 0; r < ((1+1)**(STAGE-s)); r = 1+r)
                  begin
                    p[(s+(0-1))<<<STAGE+r<<<1] <= p[r+(1<<STAGE*s)] && !a[s+(0-1)];
                    p[1+((s+(0-1))<<<STAGE+r<<<1)] <= a[s+(0-1)] && p[r+(1<<STAGE*s)];
                  end
            end
        for (i = 0; i < 1<<STAGE; i = i+1)
            begin
              code[i] <= p[i];
            end
      end
endmodule

