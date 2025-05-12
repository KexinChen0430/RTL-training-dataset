
module xtime(output [7:0] y,
             input  [7:0] x);

  wire [7:0] w;

  assign w = 2*x;
  assign y = x[7] ? ((w & (8'h1B | ~8'h1B)) ^ 8'h1B) : w;
endmodule

