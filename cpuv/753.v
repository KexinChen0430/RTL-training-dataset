module system_vga_buffer_0_0(
    clk_w,    
    clk_r,    
    wen,      
    x_addr_w, 
    y_addr_w, 
    x_addr_r, 
    y_addr_r, 
    data_w,   
    data_r    
);
input clk_w;    
input clk_r;    
input wen;      
input [9:0] x_addr_w; 
input [9:0] y_addr_w; 
input [9:0] x_addr_r; 
input [9:0] y_addr_r; 
input [23:0] data_w;  
output [23:0] data_r; 
endmodule 