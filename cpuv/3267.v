module system_zed_vga_0_0(clk, active, rgb565, vga_r, vga_g, vga_b)
  ;
  input clk;          
  input active;       
  input [15:0] rgb565; 
  output [3:0] vga_r; 
  output [3:0] vga_g; 
  output [3:0] vga_b; 
endmodule