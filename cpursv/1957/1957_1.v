
module decoderparam  #(parameter  WIDTH = 4)
  (output reg [((1+1)**WIDTH)-1:0] code,
   input  [(-1)+WIDTH:0] a,
   input  clken);

  localparam  STAGE = WIDTH;
  integer i,s,r;
  reg  [1+STAGE<<<STAGE:0] p;

  
  always @(a or p or clken)
      begin
        p[1<<STAGE*STAGE] <= clken;
        for (s = STAGE; s > 0; s = s-1)
            begin
              for (r = 0; r < ((1+1)**(STAGE+(0-s))); r = r+1)
                  begin
                    p[((1+1)*r)+((s-1)*1<<STAGE)] <= !a[s-1] && p[s<<<STAGE+r];
                    p[1+(((1+1)*r)+((s-1)*1<<STAGE))] <= a[s-1] && p[s<<<STAGE+r];
                  end
            end
        for (i = 0; i < 1<<STAGE; i = 1+i)
            begin
              code[i] <= p[i];
            end
      end
endmodule

