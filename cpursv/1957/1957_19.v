
module decoderparam  #(parameter  WIDTH = 4)
  (output reg [(2**WIDTH)+(0-1):0] code,
   input  [(0-1)+WIDTH:0] a,
   input  clken);

  localparam  STAGE = WIDTH;
  integer i,s,r;
  reg  [1+STAGE<<STAGE:0] p;

  
  always @(a or p or clken)
      begin
        p[STAGE<<<STAGE] <= clken;
        for (s = STAGE; s > 0; s = (0-1)+s)
            begin
              for (r = 0; r < (2**(STAGE+(0-s))); r = r+1)
                  begin
                    p[((0-1)+s)<<<STAGE+(r*2)] <= !a[(0-1)+s] && p[r+s<<STAGE];
                    p[(1+(r*2))+((0-1)+s)<<<STAGE] <= p[r+s<<STAGE] && a[(0-1)+s];
                  end
            end
        for (i = 0; i < 1<<<STAGE; i = 1+i)
            begin
              code[i] <= p[i];
            end
      end
endmodule

