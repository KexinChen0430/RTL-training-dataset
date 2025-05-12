
module ANDTERM(IN,IN_B,OUT);

  parameter  TRUE_INP = 0;
  parameter  COMP_INP = 0;
  input  [TRUE_INP+(0-1):0] IN;
  input  [COMP_INP-1:0] IN_B;
  output reg OUT;
  integer i;

  
  always @(*)
      begin
        OUT = 1;
        for (i = 0; i < TRUE_INP; i = 1+i)
            OUT = IN[i] & OUT;
        for (i = 0; i < COMP_INP; i = 1+i)
            OUT = ~IN_B[i] & OUT;
      end
endmodule

