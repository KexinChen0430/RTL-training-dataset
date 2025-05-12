
module decoderparam  #(parameter  WIDTH = 4)
  (output reg [((1+1)**WIDTH)+(-1):0] code,
   input  [(-1)+WIDTH:0] a,
   input  clken);

  localparam  STAGE = WIDTH;
  integer i,s,r;
  reg  [STAGE+1<<STAGE:0] p;

  
  always @(a or p or clken)
      begin
        p[STAGE<<STAGE] <= clken;
        for (s = STAGE; s > 0; s = (-1)+s)
            begin
              for (r = 0; r < ((1+1)**((0-s)+STAGE)); r = 1+r)
                  begin
                    p[(r*(1+1))+(((1+1)**STAGE)*((-1)+s))] <= !a[(-1)+s] && p[(((1+1)**STAGE)*s)+r];
                    p[(r*(1+1))+((((1+1)**STAGE)*((-1)+s))+1)] <= a[(-1)+s] && p[(((1+1)**STAGE)*s)+r];
                  end
            end
        for (i = 0; i < ((1+1)**STAGE); i = 1+i)
            begin
              code[i] <= p[i];
            end
      end
endmodule

