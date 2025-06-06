
module pxor_4w21w(clk,rst,clk_ena,pbus_in,busout);

  parameter  WIDTH = 8;
  input  clk,rst,clk_ena;
  input  [(0-1)+(WIDTH*4):0] pbus_in;
  output [WIDTH-1:0] busout;
  wire [WIDTH-1:0] out_tmp;
  reg  [WIDTH-1:0] out_tmp_reg;

  assign out_tmp = (~((~pbus_in[(0-1)+(WIDTH*4):3*WIDTH] | ~pbus_in[(0-1)+(3*WIDTH):WIDTH*2]) & (pbus_in[(0-1)+(WIDTH*4):3*WIDTH] | (pbus_in[(0-1)+(3*WIDTH):WIDTH*2] & ~pbus_in[(0-1)+(WIDTH*4):3*WIDTH]))) & (((pbus_in[(WIDTH-1)+WIDTH:WIDTH] | ~pbus_in[(WIDTH-1)+WIDTH:WIDTH]) & ((~pbus_in[WIDTH-1:0] | pbus_in[WIDTH-1:0]) & pbus_in[(WIDTH-1)+WIDTH:WIDTH])) ^ ((pbus_in[(WIDTH-1)+WIDTH:WIDTH] | ~pbus_in[(WIDTH-1)+WIDTH:WIDTH]) & ((~pbus_in[WIDTH-1:0] | pbus_in[WIDTH-1:0]) & pbus_in[WIDTH-1:0])))) | ((pbus_in[(0-1)+(WIDTH*4):3*WIDTH] | (pbus_in[(0-1)+(3*WIDTH):WIDTH*2] & ~pbus_in[(0-1)+(WIDTH*4):3*WIDTH])) & ((((~((~pbus_in[(0-1)+(WIDTH*4):3*WIDTH] | ~pbus_in[(0-1)+(3*WIDTH):WIDTH*2]) & (pbus_in[(0-1)+(WIDTH*4):3*WIDTH] | (pbus_in[(0-1)+(3*WIDTH):WIDTH*2] & ~pbus_in[(0-1)+(WIDTH*4):3*WIDTH]))) | (pbus_in[(0-1)+(WIDTH*4):3*WIDTH] | (pbus_in[(0-1)+(3*WIDTH):WIDTH*2] & ~pbus_in[(0-1)+(WIDTH*4):3*WIDTH]))) & (~((~pbus_in[(0-1)+(WIDTH*4):3*WIDTH] | ~pbus_in[(0-1)+(3*WIDTH):WIDTH*2]) & (pbus_in[(0-1)+(WIDTH*4):3*WIDTH] | (pbus_in[(0-1)+(3*WIDTH):WIDTH*2] & ~pbus_in[(0-1)+(WIDTH*4):3*WIDTH]))) | ((~(((pbus_in[(WIDTH-1)+WIDTH:WIDTH] | ~pbus_in[(WIDTH-1)+WIDTH:WIDTH]) & ((~pbus_in[WIDTH-1:0] | pbus_in[WIDTH-1:0]) & pbus_in[(WIDTH-1)+WIDTH:WIDTH])) ^ ((pbus_in[(WIDTH-1)+WIDTH:WIDTH] | ~pbus_in[(WIDTH-1)+WIDTH:WIDTH]) & ((~pbus_in[WIDTH-1:0] | pbus_in[WIDTH-1:0]) & pbus_in[WIDTH-1:0]))) & (~pbus_in[(0-1)+(3*WIDTH):WIDTH*2] & pbus_in[(0-1)+(WIDTH*4):3*WIDTH])) | (~(((pbus_in[(WIDTH-1)+WIDTH:WIDTH] | ~pbus_in[(WIDTH-1)+WIDTH:WIDTH]) & ((~pbus_in[WIDTH-1:0] | pbus_in[WIDTH-1:0]) & pbus_in[(WIDTH-1)+WIDTH:WIDTH])) ^ ((pbus_in[(WIDTH-1)+WIDTH:WIDTH] | ~pbus_in[(WIDTH-1)+WIDTH:WIDTH]) & ((~pbus_in[WIDTH-1:0] | pbus_in[WIDTH-1:0]) & pbus_in[WIDTH-1:0]))) & ~pbus_in[(0-1)+(WIDTH*4):3*WIDTH])))) & ~pbus_in[(0-1)+(WIDTH*4):3*WIDTH]) | (((~((~pbus_in[(0-1)+(WIDTH*4):3*WIDTH] | ~pbus_in[(0-1)+(3*WIDTH):WIDTH*2]) & (pbus_in[(0-1)+(WIDTH*4):3*WIDTH] | (pbus_in[(0-1)+(3*WIDTH):WIDTH*2] & ~pbus_in[(0-1)+(WIDTH*4):3*WIDTH]))) | (pbus_in[(0-1)+(WIDTH*4):3*WIDTH] | (pbus_in[(0-1)+(3*WIDTH):WIDTH*2] & ~pbus_in[(0-1)+(WIDTH*4):3*WIDTH]))) & (~((~pbus_in[(0-1)+(WIDTH*4):3*WIDTH] | ~pbus_in[(0-1)+(3*WIDTH):WIDTH*2]) & (pbus_in[(0-1)+(WIDTH*4):3*WIDTH] | (pbus_in[(0-1)+(3*WIDTH):WIDTH*2] & ~pbus_in[(0-1)+(WIDTH*4):3*WIDTH]))) | ((~(((pbus_in[(WIDTH-1)+WIDTH:WIDTH] | ~pbus_in[(WIDTH-1)+WIDTH:WIDTH]) & ((~pbus_in[WIDTH-1:0] | pbus_in[WIDTH-1:0]) & pbus_in[(WIDTH-1)+WIDTH:WIDTH])) ^ ((pbus_in[(WIDTH-1)+WIDTH:WIDTH] | ~pbus_in[(WIDTH-1)+WIDTH:WIDTH]) & ((~pbus_in[WIDTH-1:0] | pbus_in[WIDTH-1:0]) & pbus_in[WIDTH-1:0]))) & (~pbus_in[(0-1)+(3*WIDTH):WIDTH*2] & pbus_in[(0-1)+(WIDTH*4):3*WIDTH])) | (~(((pbus_in[(WIDTH-1)+WIDTH:WIDTH] | ~pbus_in[(WIDTH-1)+WIDTH:WIDTH]) & ((~pbus_in[WIDTH-1:0] | pbus_in[WIDTH-1:0]) & pbus_in[(WIDTH-1)+WIDTH:WIDTH])) ^ ((pbus_in[(WIDTH-1)+WIDTH:WIDTH] | ~pbus_in[(WIDTH-1)+WIDTH:WIDTH]) & ((~pbus_in[WIDTH-1:0] | pbus_in[WIDTH-1:0]) & pbus_in[WIDTH-1:0]))) & ~pbus_in[(0-1)+(WIDTH*4):3*WIDTH])))) & (~pbus_in[(0-1)+(3*WIDTH):WIDTH*2] & pbus_in[(0-1)+(WIDTH*4):3*WIDTH]))));
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) out_tmp_reg <= 0;
        else if (clk_ena) out_tmp_reg <= out_tmp;
          
      end
  assign busout = out_tmp_reg;
endmodule

