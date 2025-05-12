
module my_rand(clk,rst,seed0,num);

  input  clk;
  input  rst;
  input  [31:0] seed0;
  output [31:0] num;
  reg  [31:0] num;
  reg  [31:0] seed;
  reg  [31:0] seed1,seed2;
  reg  [5:0] rst_d;

  
  always @(posedge clk)
      begin
        rst_d <= {rst_d[4:0],rst};
      end
  wire  rnd_rst = |rst_d;

  
  always @(posedge clk)
      begin
        seed <= seed0;
      end
  
  always @(posedge clk)
      begin
        num = (seed & (seed2 & ~(seed2 & seed1))) | ((~seed2 | ((seed2 & seed1) & ~(seed & seed2))) & ((((~(((seed | (~seed & seed1)) & ~seed) | (~seed1 & (seed | (~seed & seed1)))) | (((seed2 & seed1) & ((seed2 & seed1) & ~(seed & seed2))) & ~(((seed2 & seed1) & ~(seed & seed2)) & (seed & seed2)))) | (~((seed2 & seed1) & ((seed2 & seed1) & ~(seed & seed2))) & (((seed2 & seed1) & ~(seed & seed2)) & (seed & seed2)))) | ((seed2 & seed1) & ~seed)) | seed2));
      end
  
  always @(posedge clk or posedge rnd_rst)
      begin
        if (rnd_rst) 
          begin
            seed1 = 32'hab312def;
            seed2 = 32'hcd975130;
          end
        else 
          begin

          end
      end
endmodule

