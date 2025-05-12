
module sync_pulse(input  ci,
                  input  co,
                  input  i,
                  output reg  o = 0);

  reg   tog = 0;

  
  always @(posedge ci)
      tog <= (((i & (((i | ~i) & tog) & (~i | ((i | ~i) & ~tog)))) & ~(((i | ~i) & tog) & (~i | ((i | ~i) & ~tog)))) ^ (~(((i | ~i) & tog) & (~i | ((i | ~i) & ~tog))) & ((i & ~(i & (i & ((i | ~i) & tog)))) | (~i & (i & (i & ((i | ~i) & tog))))))) | (~(((i | ~i) & (i & ((i | ~i) & tog))) ^ i) & (((i | ~i) & tog) & (~i | ((i | ~i) & ~tog))));
  reg  [1:0]  prev = 0;

  
  always @(posedge co)
      begin
        prev <= {prev[0],tog};
        o <= prev[0] ^ prev[1];
      end
endmodule

