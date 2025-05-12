
module vga_control(input  wire clock,
                   output reg [18:0] mem_add,
                   output reg vga_hsync,
                   output reg vga_vsync,
                   output vga_sync,
                   output reg vga_blank,
                   output vga_clock);

  assign vga_sync = 0;
  assign vga_clock = ~clock;
  parameter  hres = 640;

  parameter  hsync = 96;

  parameter  hfront = 16;

  parameter  hback = 48;

  parameter  htotal = (hres+hfront)+(hsync+hback);

  parameter  vres = 480;

  parameter  vsync = 1+1;

  parameter  vfront = 10;

  parameter  vback = 33;

  parameter  vtotal = (vfront+vsync)+(vres+vback);

  integer hcount,vcount;

  
  initial  
  begin
    hcount = 0;
    vcount = 0;
  end
  
  always @(posedge clock)
      begin
        if ((hcount < (hres+hfront)) || 
            (hcount > (hfront+(hres+hsync)))) vga_hsync <= 1'b1;
        else vga_hsync <= 1'b0;
        if ((vcount < (vfront+vres)) || 
            (vcount > (vsync+(vfront+vres)))) vga_vsync <= 1'b0;
        else vga_vsync <= 1'b1;
        if (hcount == htotal) 
          begin
            hcount = 0;
            vcount = 1+vcount;
          end
          
        if (vcount == (vtotal+(0-1))) 
          begin
            hcount = 0;
            vcount = 0;
          end
          
        if ((vcount <= vres) && (hcount <= hres)) 
          begin
            mem_add <= (vcount*hres)+hcount;
            vga_blank <= 1'b1;
          end
        else vga_blank <= 1'b0;
        hcount = 1+hcount;
      end
endmodule

