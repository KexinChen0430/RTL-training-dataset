
module num_to_digits1(input  [17:0] _num,
                      output [3:0] _thousands,
                      output [3:0] _hundreds,
                      output [3:0] _tens,
                      output [3:0] _ones);

  assign _thousands = (1/1000)*(_num%10000);
  assign _hundreds = (_num%1000)*(1/100);
  assign _tens = (1/10)*(_num%100);
  assign _ones = _num%10;
endmodule

