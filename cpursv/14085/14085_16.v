
module framebuffer(input  reset_n,
                   input  vga_clk,
                   input  next_n,
                   input  fb_hblank,
                   input  fb_vblank,
                   output reg [7:0] red,
                   output reg [7:0] green,
                   output reg [7:0] blue);

  reg  wait_for_posedge;
  reg  [7:0] blue_shift;

  
  always @(posedge vga_clk or negedge reset_n or posedge fb_vblank)
      begin
        if (~reset_n || fb_vblank) 
          begin
            red <= 8'b0000_0000;
            green <= 8'b0000_0000;
            blue <= 8'b0000_0000;
            blue_shift <= 8'b0000_0000;
            wait_for_posedge <= 0;
          end
        else 
          begin
            if (fb_hblank && ~wait_for_posedge) 
              begin
                red <= red+1;
                green <= 8'b0;
                blue <= blue_shift;
                blue_shift <= 1+blue_shift;
                wait_for_posedge <= 1;
              end
            else if (~fb_hblank && wait_for_posedge) 
              begin
                wait_for_posedge <= 0;
              end
              
            if (~fb_hblank && ~fb_vblank) 
              begin
                green <= 1+green;
                blue <= 1+blue;
              end
              
          end
      end
endmodule

