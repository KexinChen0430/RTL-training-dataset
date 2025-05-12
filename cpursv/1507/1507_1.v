
module system_vga_sync_ref_1_0(clk,rst,hsync,vsync,start,active,xaddr,yaddr);

  input  clk;
  input  rst;
  input  hsync;
  input  vsync;
  output start;
  output active;
  output [9:0] xaddr;
  output [9:0] yaddr;


endmodule

