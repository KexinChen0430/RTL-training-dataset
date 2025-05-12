
module decoderparam  #(parameter  WIDTH = 4)
  (output reg [(2**WIDTH)+(-1):0] code,
   input  [WIDTH+(-1):0] a,
   input  clken);

  localparam  STAGE = WIDTH;
  integer i,s,r;
  reg  [1+STAGE<<<STAGE:0] p;

  
  always @(a or p or clken)
      begin
        p[STAGE<<STAGE] <= clken;
        for (s = STAGE; s > 0; s = (-1)+s)
            begin
              for (r = 0; r < (2**(STAGE+(0-s))); r = 1+r)
                  begin
                    p[(r*2)+((-1)+s)<<<STAGE] <= !a[(-1)+s] && p[r+s<<<STAGE];
                    p[((r*2)+((-1)+s)<<<STAGE)+1] <= a[(-1)+s] && p[r+s<<<STAGE];
                  end
            end
        for (i = 0; i < 1<<<STAGE; i = 1+i)
            begin
              code[i] <= p[i];
            end
      end
endmodule

