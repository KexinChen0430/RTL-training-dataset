
module decoderparam  #(parameter  WIDTH = 4)
  (output reg [(2**WIDTH)-1:0] code,
   input  [(0-1)+WIDTH:0] a,
   input  clken);

  localparam  STAGE = WIDTH;
  integer i,s,r;
  reg  [(2**STAGE)*(STAGE+1):0] p;

  
  always @(a or p or clken)
      begin
        p[STAGE*(2**STAGE)] <= clken;
        for (s = STAGE; s > 0; s = s+(0-1))
            begin
              for (r = 0; r < (2**(STAGE+(-s))); r = 1+r)
                  begin
                    p[(s+(0-1))<<STAGE+(2*r)] <= !a[s+(0-1)] && p[s<<STAGE+r];
                    p[((2*r)+1)+(s+(0-1))<<STAGE] <= p[s<<STAGE+r] && a[s+(0-1)];
                  end
            end
        for (i = 0; i < (2**STAGE); i = i+1)
            begin
              code[i] <= p[i];
            end
      end
endmodule

