
module ANDTERM(IN,IN_B,OUT);

  parameter  TRUE_INP = 0;
  parameter  COMP_INP = 0;
  input  [(-1)+TRUE_INP:0] IN;
  input  [(-1)+COMP_INP:0] IN_B;
  output reg OUT;
  integer i;

  
  always @(*)
      begin
        OUT = 1;
        for (i = 0; i < TRUE_INP; i = i+1)
            OUT = IN[i] & OUT;
        for (i = 0; i < COMP_INP; i = i+1)
            OUT = ~IN_B[i] & OUT;
      end
endmodule

