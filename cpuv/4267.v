module system_vga_transform_0_1(
    clk,            
    enable,         
    x_addr_in,      
    y_addr_in,      
    rot_m00,        
    rot_m01,        
    rot_m10,        
    rot_m11,        
    t_x,            
    t_y,            
    x_addr_out,     
    y_addr_out      
)
;
    input clk;                  
    input enable;               
    input [9:0] x_addr_in;      
    input [9:0] y_addr_in;      
    input [15:0] rot_m00;       
    input [15:0] rot_m01;       
    input [15:0] rot_m10;       
    input [15:0] rot_m11;       
    input [9:0] t_x;            
    input [9:0] t_y;            
    output [9:0] x_addr_out;    
    output [9:0] y_addr_out;    
endmodule