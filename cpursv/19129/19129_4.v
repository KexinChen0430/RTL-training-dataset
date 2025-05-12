
module pxor_4w21w(clk,rst,clk_ena,pbus_in,busout);

  parameter  WIDTH = 8;
  input  clk,rst,clk_ena;
  input  [(4*WIDTH)+(0-1):0] pbus_in;
  output [(0-1)+WIDTH:0] busout;
  wire [(0-1)+WIDTH:0] out_tmp;
  reg  [(0-1)+WIDTH:0] out_tmp_reg;

  assign out_tmp = ((((~pbus_in[(0-1)+WIDTH:0] | ~pbus_in[WIDTH<<<1-1:WIDTH]) & ~pbus_in[(0-1)+WIDTH:0]) & pbus_in[WIDTH<<<1-1:WIDTH]) & ~(((~pbus_in[(0-1)+(WIDTH*3):WIDTH<<<1] & pbus_in[(4*WIDTH)+(0-1):WIDTH*3]) | ~pbus_in[(4*WIDTH)+(0-1):WIDTH*3]) & ((pbus_in[(4*WIDTH)+(0-1):WIDTH*3] | pbus_in[(0-1)+(WIDTH*3):WIDTH<<<1]) & (~pbus_in[(4*WIDTH)+(0-1):WIDTH*3] | pbus_in[(4*WIDTH)+(0-1):WIDTH*3])))) | (((~pbus_in[WIDTH<<<1-1:WIDTH] & pbus_in[(0-1)+WIDTH:0]) | (~(((~pbus_in[(0-1)+WIDTH:0] | ~pbus_in[WIDTH<<<1-1:WIDTH]) & pbus_in[(0-1)+WIDTH:0]) | (((~pbus_in[(0-1)+WIDTH:0] | ~pbus_in[WIDTH<<<1-1:WIDTH]) & ~pbus_in[(0-1)+WIDTH:0]) & pbus_in[WIDTH<<<1-1:WIDTH])) & ((~pbus_in[(4*WIDTH)+(0-1):WIDTH*3] | (pbus_in[(4*WIDTH)+(0-1):WIDTH*3] & (~(((~pbus_in[(0-1)+WIDTH:0] | ~pbus_in[WIDTH<<<1-1:WIDTH]) & pbus_in[(0-1)+WIDTH:0]) | (((~pbus_in[(0-1)+WIDTH:0] | ~pbus_in[WIDTH<<<1-1:WIDTH]) & ~pbus_in[(0-1)+WIDTH:0]) & pbus_in[WIDTH<<<1-1:WIDTH])) & ~pbus_in[(0-1)+(WIDTH*3):WIDTH<<<1]))) & ((pbus_in[(4*WIDTH)+(0-1):WIDTH*3] & (~(((~pbus_in[(0-1)+WIDTH:0] | ~pbus_in[WIDTH<<<1-1:WIDTH]) & pbus_in[(0-1)+WIDTH:0]) | (((~pbus_in[(0-1)+WIDTH:0] | ~pbus_in[WIDTH<<<1-1:WIDTH]) & ~pbus_in[(0-1)+WIDTH:0]) & pbus_in[WIDTH<<<1-1:WIDTH])) & ~pbus_in[(0-1)+(WIDTH*3):WIDTH<<<1])) | pbus_in[(0-1)+(WIDTH*3):WIDTH<<<1])))) & (~(((~pbus_in[(0-1)+WIDTH:0] | ~pbus_in[WIDTH<<<1-1:WIDTH]) & pbus_in[(0-1)+WIDTH:0]) | (((~pbus_in[(0-1)+WIDTH:0] | ~pbus_in[WIDTH<<<1-1:WIDTH]) & ~pbus_in[(0-1)+WIDTH:0]) & pbus_in[WIDTH<<<1-1:WIDTH])) | ~(((~pbus_in[(0-1)+(WIDTH*3):WIDTH<<<1] & pbus_in[(4*WIDTH)+(0-1):WIDTH*3]) | ~pbus_in[(4*WIDTH)+(0-1):WIDTH*3]) & ((pbus_in[(4*WIDTH)+(0-1):WIDTH*3] | pbus_in[(0-1)+(WIDTH*3):WIDTH<<<1]) & (~pbus_in[(4*WIDTH)+(0-1):WIDTH*3] | pbus_in[(4*WIDTH)+(0-1):WIDTH*3])))));
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) out_tmp_reg <= 0;
        else if (clk_ena) out_tmp_reg <= out_tmp;
          
      end
  assign busout = out_tmp_reg;
endmodule

