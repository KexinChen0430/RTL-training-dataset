module system_vga_sync_0_0(
    clk_25,  
    rst,     
    active,  
    hsync,   
    vsync,   
    xaddr,   
    yaddr    
)
input clk_25;        
input rst;           
output active;       
output hsync;        
output vsync;        
output [9:0] xaddr;  
output [9:0] yaddr;  
endmodule 