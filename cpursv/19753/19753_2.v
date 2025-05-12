
module xorshift32(input  wire clk,
                  input  wire resetq,
                  input  wire gen,
                  output wire [31:0] r);

  reg  [31:0]  seed = 32'h7;
  wire [31:0] 
       seed0 = (~seed & ((((~{seed[18:0],13'd0} | ~seed) | seed) & {seed[18:0],13'd0}) | seed)) | (~{seed[18:0],13'd0} & ((((~{seed[18:0],13'd0} | ~seed) | seed) & {seed[18:0],13'd0}) | seed));
  wire [31:0]  seed1 = {17'd0,seed0[31:17]} ^ seed0;
  wire [31:0] 
       seed2 = {seed1[26:0],5'd0} ^ (({seed1[26:0],5'd0} | ~{seed1[26:0],5'd0}) & seed1);

  
  always @(posedge clk or negedge resetq)
      if (!resetq) seed <= 32'h7;
      else if (gen) seed <= seed2;
        
  assign r = seed;
endmodule

