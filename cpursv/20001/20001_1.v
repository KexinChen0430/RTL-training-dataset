
module ORTERM(IN,OUT);

  parameter  WIDTH = 0;
  input  [WIDTH+(0-1):0] IN;
  output reg OUT;
  integer i;

  
  always @(*)
      begin
        OUT = 0;
        for (i = 0; i < WIDTH; i = 1+i)
            begin
              OUT = IN[i] | OUT;
            end
      end
endmodule

