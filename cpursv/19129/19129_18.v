
module pxor_4w21w(clk,rst,clk_ena,pbus_in,busout);

  parameter  WIDTH = 8;
  input  clk,rst,clk_ena;
  input  [(4*WIDTH)-1:0] pbus_in;
  output [WIDTH+(0-1):0] busout;
  wire [WIDTH+(0-1):0] out_tmp;
  reg  [WIDTH+(0-1):0] out_tmp_reg;

  assign out_tmp = ((~pbus_in[WIDTH+(0-1):0] & pbus_in[(0-1)+(WIDTH*1<<<1):WIDTH]) | ((~pbus_in[(0-1)+(WIDTH*1<<<1):WIDTH] | ~pbus_in[WIDTH+(0-1):0]) & pbus_in[WIDTH+(0-1):0])) ^ (((pbus_in[(WIDTH*3)-1:WIDTH*1<<<1] | ~pbus_in[(WIDTH*3)-1:WIDTH*1<<<1]) & ((((pbus_in[(4*WIDTH)-1:WIDTH*3] & (pbus_in[(WIDTH*3)-1:WIDTH*1<<<1] | ~pbus_in[(WIDTH*3)-1:WIDTH*1<<<1])) & (~pbus_in[(WIDTH*3)-1:WIDTH*1<<<1] | ~pbus_in[(4*WIDTH)-1:WIDTH*3])) | (~pbus_in[(WIDTH*3)-1:WIDTH*1<<<1] | ~pbus_in[(4*WIDTH)-1:WIDTH*3])) & pbus_in[(WIDTH*3)-1:WIDTH*1<<<1])) ^ ((pbus_in[(WIDTH*3)-1:WIDTH*1<<<1] | ~pbus_in[(WIDTH*3)-1:WIDTH*1<<<1]) & ((((pbus_in[(4*WIDTH)-1:WIDTH*3] & (pbus_in[(WIDTH*3)-1:WIDTH*1<<<1] | ~pbus_in[(WIDTH*3)-1:WIDTH*1<<<1])) & (~pbus_in[(WIDTH*3)-1:WIDTH*1<<<1] | ~pbus_in[(4*WIDTH)-1:WIDTH*3])) | (~pbus_in[(WIDTH*3)-1:WIDTH*1<<<1] | ~pbus_in[(4*WIDTH)-1:WIDTH*3])) & pbus_in[(4*WIDTH)-1:WIDTH*3])));
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) out_tmp_reg <= 0;
        else if (clk_ena) out_tmp_reg <= out_tmp;
          
      end
  assign busout = out_tmp_reg;
endmodule

