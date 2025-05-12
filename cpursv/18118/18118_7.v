
module xtime(output [7:0] y,
             input  [7:0] x);

  wire [7:0] w;

  assign w = x*2;
  assign y = x[7] ? (((((((w | 8'h1B) | ~8'h1B) & w) & ((~w & 8'h1B) | ~8'h1B)) & 8'h1B) | (~w & 8'h1B)) ^ (((((w | 8'h1B) | ~8'h1B) & w) & ((~w & 8'h1B) | ~8'h1B)) & (w | 8'h1B))) : w;
endmodule

