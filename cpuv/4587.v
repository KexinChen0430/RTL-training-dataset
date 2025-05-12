module system_vga_sync_reset_0_0(clk, rst, active, hsync, vsync, xaddr, yaddr)
;
  input clk;  
  input rst;  
  output active;  
  output hsync;   
  output vsync;   
  output [9:0]xaddr;  
  output [9:0]yaddr;  
endmodule