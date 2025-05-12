module painter_chooser(
    input [9:0] hc,           
    input [9:0] vc,           
    input [9:0] mouse_x,      
    input [8:0] mouse_y,      
    input [7:0] rgb_background, 
    input [7:0] line_code,    
    output reg [9:0] hpos,    
    output reg [8:0] vpos,    
    output reg [4:0] line_number, 
    output reg [7:0] rgb      
);
parameter [7:0] hbp = 144;   
parameter [4:0] vbp = 31;    
parameter [7:0] black = 8'b00000000;
parameter [7:0] lblue = 8'b00001011;
parameter [7:0] lred  = 8'b10000000;
always @(*)
begin
    vpos = {vc - vbp}[8:0];
    hpos = hc - hbp;
    line_number = 0;
    rgb = rgb_background;
    if( hpos >= mouse_x && hpos < (mouse_x + 8) 
        && vpos >= mouse_y && vpos < (mouse_y + 11))
    begin
        line_number = {vpos - mouse_y}[4:0];
        if(line_code[hpos-mouse_x])
            rgb = black;
    end 
end
endmodule