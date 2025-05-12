module vga
#(
    parameter WIDTH = 0, 
    parameter HSIZE = 0, 
    parameter HFP = 0,   
    parameter HSP = 0,   
    parameter HMAX = 0,  
    parameter VSIZE = 0, 
    parameter VFP = 0,   
    parameter VSP = 0,   
    parameter VMAX = 0,  
    parameter HSPP = 0,  
    parameter VSPP = 0   
)
(
    input clk,                 
    output wire hsync,         
    output wire vsync,         
    output reg [WIDTH - 1:0] hdata, 
    output reg [WIDTH - 1:0] vdata, 
    output wire data_enable    
);
initial begin
    hdata <= 0;
    vdata <= 0;
end
always @ (posedge clk)
begin
    if (hdata == (HMAX - 1)) 
        hdata <= 0;          
    else
        hdata <= hdata + 1;  
end
always @ (posedge clk)
begin
    if (hdata == (HMAX - 1)) 
    begin
        if (vdata == (VMAX - 1)) 
            vdata <= 0;          
        else
            vdata <= vdata + 1;  
    end
end
assign hsync = ((hdata >= HFP) && (hdata < HSP)) ? HSPP : !HSPP; 
assign vsync = ((vdata >= VFP) && (vdata < VSP)) ? VSPP : !VSPP; 
assign data_enable = ((hdata < HSIZE) & (vdata < VSIZE)); 
endmodule 