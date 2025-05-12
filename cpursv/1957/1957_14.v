
module decoderparam  #(parameter  WIDTH = 4)
  (output reg [(2**WIDTH)-1:0] code,
   input  [(0-1)+WIDTH:0] a,
   input  clken);

  localparam  STAGE = WIDTH;
  integer i,s,r;
  reg  [1<<<STAGE*(STAGE+1):0] p;

  
  always @(a or p or clken)
      begin
        p[STAGE<<<STAGE] <= clken;
        for (s = STAGE; s > 0; s = s+(0-1))
            begin
              for (r = 0; r < (2**(STAGE-s)); r = 1+r)
                  begin
                    p[((s+(0-1))*1<<<STAGE)+r<<<1] <= p[r+s<<<STAGE] && !a[s+(0-1)];
                    p[(((s+(0-1))*1<<<STAGE)+r<<<1)+1] <= a[s+(0-1)] && p[r+s<<<STAGE];
                  end
            end
        for (i = 0; i < 1<<<STAGE; i = i+1)
            begin
              code[i] <= p[i];
            end
      end
endmodule

