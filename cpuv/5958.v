module system_vga_feature_transform_0_0(clk, clk_x2, rst, active, vsync, x_addr_0, y_addr_0,
  hessian_0, x_addr_1, y_addr_1, hessian_1, rot_m00, rot_m01, rot_m10, rot_m11, t_x, t_y, state)
;
  input clk;
  input clk_x2;
  input rst;
  input active;
  input vsync;
  input [9:0]x_addr_0;
  input [9:0]y_addr_0;
  input [31:0]hessian_0;
  input [9:0]x_addr_1;
  input [9:0]y_addr_1;
  input [31:0]hessian_1;
  output [15:0]rot_m00;
  output [15:0]rot_m01;
  output [15:0]rot_m10;
  output [15:0]rot_m11;
  output [9:0]t_x;
  output [9:0]t_y;
  output [1:0]state;
endmodule