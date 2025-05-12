
module xtime(output [7:0] y,
             input  [7:0] x);

  wire [7:0] w;

  assign w = x<<1;
  assign y = x[7] ? (((8'h1B & ~w) ^ (~w & (w & (((w ^ (w & 8'h1B)) | ~w) | 8'h1B)))) | ((w | 8'h1B) & (w ^ (w & 8'h1B)))) : w;
endmodule

