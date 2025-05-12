
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

  parameter  htotal = (hsync+hfront)+(hback+hres);

  parameter  vres = 480;

  parameter  vsync = 1<<<1;

  parameter  vfront = 10;

  parameter  vback = 33;

  parameter  vtotal = ((vres+vfront)+vback)+vsync;

  integer hcount,vcount;

  
  initial  
  begin
    hcount = 0;
    vcount = 0;
  end
  
  always @(posedge clock)
      begin
        if ((hcount > ((hfront+hres)+hsync)) || 
            (hcount < (hfront+hres))) vga_hsync <= 1'b1;
        else vga_hsync <= 1'b0;
        if ((vcount < (vres+vfront)) || 
            (vcount > (vres+(vfront+vsync)))) vga_vsync <= 1'b0;
        else vga_vsync <= 1'b1;
        if (hcount == htotal) 
          begin
            hcount = 0;
            vcount = 1+vcount;
          end
          
        if (vcount == (vtotal-1)) 
          begin
            hcount = 0;
            vcount = 0;
          end
          
        if ((hcount <= hres) && (vcount <= vres)) 
          begin
            mem_add <= (vcount*hres)+hcount;
            vga_blank <= 1'b1;
          end
        else vga_blank <= 1'b0;
        hcount = 1+hcount;
      end
endmodule

