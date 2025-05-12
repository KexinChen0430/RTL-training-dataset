
module decoderparam  #(parameter  WIDTH = 4)
  (output reg [((1+1)**WIDTH)+(0-1):0] code,
   input  [WIDTH+(0-1):0] a,
   input  clken);

  localparam  STAGE = WIDTH;
  integer i,s,r;
  reg  [((1+1)**STAGE)*(STAGE+1):0] p;

  
  always @(a or p or clken)
      begin
        p[STAGE<<<STAGE] <= clken;
        for (s = STAGE; s > 0; s = s+(0-1))
            begin
              for (r = 0; r < ((1+1)**(STAGE-s)); r = r+1)
                  begin
                    p[(r*(1+1))+((s+(0-1))*((1+1)**STAGE))] <= !a[s+(0-1)] && p[(((1+1)**STAGE)*s)+r];
                    p[(r*(1+1))+(1+((s+(0-1))*((1+1)**STAGE)))] <= a[s+(0-1)] && p[(((1+1)**STAGE)*s)+r];
                  end
            end
        for (i = 0; i < ((1+1)**STAGE); i = 1+i)
            begin
              code[i] <= p[i];
            end
      end
endmodule

