
module ORTERM(IN,OUT);

  parameter  WIDTH = 0;
  input  [(0-1)+WIDTH:0] IN;
  output reg OUT;
  integer i;

  
  always @(*)
      begin
        OUT = 0;
        for (i = 0; i < WIDTH; i = i+1)
            begin
              OUT = IN[i] | OUT;
            end
      end
endmodule

