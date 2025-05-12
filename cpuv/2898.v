module Player
#( parameter
    SMALL   = 40, 
    BIG     = 80  
)
(
    input wire [9:0] xpos, 
    input wire [8:0] ypos, 
    input wire direction,  
    input wire size,       
    input wire fire,       
    input wire [9:0] hcount_in, 
    input wire hsync_in,   
    input wire [9:0] vcount_in, 
    input wire vsync_in,   
    input wire blnk_in,    
    input wire rst,        
    input wire clk,        
    input wire [23:0] rgb_in, 
    input wire [23:0] rom_data, 
    output reg [10:0] rom_addr, 
    output reg [9:0] hcount_out, 
    output reg hsync_out,  
    output reg [9:0] vcount_out, 
    output reg vsync_out,  
    output reg [23:0] rgb_out, 
    output reg blnk_out    
    );