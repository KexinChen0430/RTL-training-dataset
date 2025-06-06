module mod_vga_encoder(
  input in_clk_25_175_mhz,       
  input [7:0] in_vga_r,          
  input [7:0] in_vga_g,          
  input [7:0] in_vga_b,          
  output [7:0] out_vga_r,        
  output [7:0] out_vga_g,        
  output [7:0] out_vga_b,        
  output out_vga_hsync,          
  output out_vga_vsync,          
  output [9:0] out_vga_next_x,   
  output [9:0] out_vga_next_y,   
  output       out_vga_active    
);
reg hsync, hsync_delay1, hsync_delay2; 
reg vsync, vsync_delay1, vsync_delay2; 
reg new_line = 0;                      
reg [9:0] pix_x = 0;                   
reg [9:0] pix_y = 0;                   
reg       active_x = 0;                
reg       active_y = 0;                
reg       active_x_delay = 0;          
reg       active_y_delay = 0;          
parameter res_x = 640;                 
parameter res_y = 480;                 
parameter hpulse = 96;                 
parameter hbp    = 48;                 
parameter hfp    = 16;                 
parameter vpulse = 2;                  
parameter vbp    = 33;                 
parameter vfp    = 10;                 
parameter hpixels = res_x + hfp + hpulse + hbp; 
parameter vlines  = res_y + vfp + vpulse + vbp; 
reg [3:0] horiz_state = 4'b1000;       
reg [3:0] vert_state = 4'b1000;        
always @(posedge in_clk_25_175_mhz) begin
  casex (horiz_state)
    4'b1xxx: begin 
      hsync <= 1'b0;                  
      active_x <= 1'b0;               
      new_line <= 1'b0;               
      if (pix_x == (hpulse - 1)) begin
        horiz_state <= 4'b0100;       
        pix_x <= 0;                   
      end else begin
        horiz_state <= 4'b1000;       
        pix_x <= pix_x + 1;           
      end
    end
    4'bx1xx: begin 
      hsync <= 1'b1;                  
      active_x <= 1'b0;               
      new_line <= 1'b0;               
      if (pix_x == (hbp - 1)) begin
        horiz_state <= 4'b0010;       
        pix_x <= 0;                   
      end else begin
        horiz_state <= 4'b0100;       
        pix_x <= pix_x + 1;           
      end
    end
    4'bxx1x: begin 
      hsync <= 1'b1;                  
      active_x <= 1'b1;               
      new_line <= 1'b0;               
      if (pix_x == (res_x - 1)) begin
        horiz_state <= 4'b0001;       
        pix_x <= 0;                   
      end else begin
        horiz_state <= 4'b0010;       
        pix_x <= pix_x + 1;           
      end
    end
    4'bxxx1: begin 
      hsync <= 1'b1;                  
      active_x <= 1'b0;               
      if (pix_x == (hfp - 2)) begin
        new_line <= 1;                
      end else begin
        new_line <= 0;                
      end
      if (pix_x == (hfp - 1)) begin
        horiz_state <= 4'b1000;       
        pix_x <= 0;                   
      end else begin
        horiz_state <= 4'b0001;       
        pix_x <= pix_x + 1;           
      end
    end
  endcase
  if (new_line) begin
    casex (vert_state)
      4'b1xxx: begin 
        vsync <= 1'b0;                
        active_y <= 1'b0;             
        if (pix_y == (vpulse - 1)) begin
          vert_state <= 4'b0100;      
          pix_y <= 0;                 
        end else begin
          vert_state <= 4'b1000;      
          pix_y <= pix_y + 1;         
        end
      end
      4'bx1xx: begin 
        vsync <= 1'b1;                
        active_y <= 1'b0;             
        if (pix_y == (vbp - 1)) begin
          vert_state <= 4'b0010;      
          pix_y <= 0;                 
        end else begin
          vert_state <= 4'b0100;      
          pix_y <= pix_y + 1;         
        end
      end
      4'bxx1x: begin 
        vsync <= 1'b1;                
        active_y <= 1'b1;             
        if (pix_y == (res_y - 1)) begin
          vert_state <= 4'b0001;      
          pix_y <= 0;                 
        end else begin
          vert_state <= 4'b0010;      
          pix_y <= pix_y + 1;         
        end
      end
      4'bxxx1: begin 
        vsync <= 1'b1;                
        active_y <= 1'b0;             
        if (pix_y == (vfp - 1)) begin
          vert_state <= 4'b1000;      
          pix_y <= 0;                 
        end else begin
          vert_state <= 4'b0001;      
          pix_y <= pix_y + 1;         
        end
      end
    endcase
  end
  hsync_delay1 <= hsync;
  hsync_delay2 <= hsync_delay1;
  vsync_delay1 <= vsync;
  vsync_delay2 <= vsync_delay1;
  active_x_delay <= active_x;
  active_y_delay <= active_y;
  if (active_x & active_y) begin
    out_vga_r <= in_vga_r;
    out_vga_g <= in_vga_g;
    out_vga_b <= in_vga_b;
  end else begin
    out_vga_r <= 0;
    out_vga_g <= 0;
    out_vga_b <= 0;
  end
end
assign out_vga_hsync = hsync_delay2;   
assign out_vga_vsync = vsync_delay2;   
assign out_vga_next_x = pix_x;         
assign out_vga_next_y = pix_y;         
assign out_vga_active = active_x;      
endmodule