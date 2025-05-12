
module num_to_digits(input  [11:0] _num,
                     output [3:0] _thousands,
                     output [3:0] _hundreds,
                     output [3:0] _tens,
                     output [3:0] _ones);

  assign _thousands = (_num%10000)*(1/1000);
  assign _hundreds = (1/100)*(_num%1000);
  assign _tens = (_num%100)/10;
  assign _ones = _num%10;
endmodule

