
module d(clock,eleventh,twelfth,out5);

  input  clock;
  input  eleventh;
  input  twelfth;
  output out5;
  reg  out5;
  reg  temp6;

  
  always @(posedge clock)
      begin
        temp6 <= ((~(twelfth & eleventh) & twelfth) | ((~twelfth & twelfth) & eleventh)) ^ ((eleventh | twelfth) & ((((~(twelfth & eleventh) & (eleventh & (eleventh & (twelfth | ~twelfth)))) | (twelfth & eleventh)) & ((~(twelfth & eleventh) & (eleventh & (eleventh & (twelfth | ~twelfth)))) | ~(eleventh & (eleventh & (twelfth | ~twelfth))))) & (eleventh | twelfth)));
        out5 <= twelfth | temp6;
      end
endmodule

