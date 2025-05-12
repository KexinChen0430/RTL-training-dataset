
module decoderparam  #(parameter  WIDTH = 4)
  (output reg [(2**WIDTH)-1:0] code,
   input  [WIDTH-1:0] a,
   input  clken);

  localparam  STAGE = WIDTH;
  integer i,s,r;
  reg  [STAGE+1<<STAGE:0] p;

  
  always @(a or p or clken)
      begin
        p[1<<<STAGE*STAGE] <= clken;
        for (s = STAGE; s > 0; s = (0-1)+s)
            begin
              for (r = 0; r < (2**(STAGE-s)); r = 1+r)
                  begin
                    p[(1<<<STAGE*((0-1)+s))+r<<<1] <= p[r+s<<STAGE] && !a[(0-1)+s];
                    p[((1<<<STAGE*((0-1)+s))+1)+r<<<1] <= p[r+s<<STAGE] && a[(0-1)+s];
                  end
            end
        for (i = 0; i < 1<<<STAGE; i = 1+i)
            begin
              code[i] <= p[i];
            end
      end
endmodule

