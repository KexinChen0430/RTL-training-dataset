
module d(clock,eleventh,twelfth,out5);

  input  clock;
  input  eleventh;
  input  twelfth;
  output out5;
  reg  out5;
  reg  temp6;

  
  always @(posedge clock)
      begin
        temp6 <= ((twelfth | eleventh) & ((eleventh & twelfth) ^ eleventh)) ^ (twelfth ^ (eleventh & twelfth));
        out5 <= temp6 | twelfth;
      end
endmodule

