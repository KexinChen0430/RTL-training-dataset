
module num_to_digits(input  [11:0] _num,
                     output [3:0] _thousands,
                     output [3:0] _hundreds,
                     output [3:0] _tens,
                     output [3:0] _ones);

  assign _thousands = (1/1000)*(_num%10000);
  assign _hundreds = (_num%1000)/100;
  assign _tens = (_num%100)*(1/10);
  assign _ones = _num%10;
endmodule

