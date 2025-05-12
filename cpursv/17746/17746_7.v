
module vga  #(parameter 
       WIDTH = 0,
       HSIZE = 0,
       HFP   = 0,
       HSP   = 0,
       HMAX  = 0,
       VSIZE = 0,
       VFP   = 0,
       VSP   = 0,
       VMAX  = 0,
       HSPP  = 0,
       VSPP  = 0)
  (input  clk,
   output wire hsync,
   output wire vsync,
   output reg [WIDTH-1:0] hdata,
   output reg [WIDTH-1:0] vdata,
   output wire data_enable);

  
  initial  
  begin
    hdata <= 0;
    vdata <= 0;
  end
  
  always @(posedge clk)
      begin
        if (hdata == (HMAX-1)) hdata <= 0;
        else hdata <= hdata+1;
      end
  
  always @(posedge clk)
      begin
        if (hdata == (HMAX-1)) 
          begin
            if (vdata == ((0-1)+VMAX)) vdata <= 0;
            else vdata <= 1+vdata;
          end
          
      end
  assign hsync = ((hdata >= HFP) && (hdata < HSP)) ? HSPP : !HSPP;
  assign vsync = ((vdata >= VFP) && (vdata < VSP)) ? VSPP : !VSPP;
  assign data_enable = (hdata < HSIZE) & (vdata < VSIZE);
endmodule

