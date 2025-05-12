module system_vga_color_test_0_0(
    clk_25, 
    xaddr,  
    yaddr,  
    rgb     
)
  input clk_25;          
  input [9:0] xaddr;     
  input [9:0] yaddr;     
  output [23:0] rgb;     
endmodule