module system_vga_gaussian_blur_1_0(
    clk_25,       
    hsync_in,     
    vsync_in,     
    rgb_in,       
    hsync_out,    
    vsync_out,    
    rgb_blur,     
    rgb_pass      
);
;
  input clk_25;        
  input hsync_in;      
  input vsync_in;      
  input [23:0]rgb_in;  
  output hsync_out;    
  output vsync_out;    
  output [23:0]rgb_blur; 
  output [23:0]rgb_pass; 
endmodule