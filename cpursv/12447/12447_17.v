
module vga_driver(r,g,b,current_x,current_y,request,vga_r,vga_g,vga_b,vga_hs,
                  vga_vs,vga_blank,vga_clock,clk27,rst27);

  input  [9:0] r,g,b;
  output [9:0] current_x;
  output [9:0] current_y;
  output request;
  output [9:0] vga_r,vga_g,vga_b;
  output vga_hs,vga_vs,vga_blank,vga_clock;
  input  clk27,rst27;
  parameter  H_FRONT = 16;
  parameter  H_SYNC = 96;
  parameter  H_BACK = 48;
  parameter  H_ACT = 640;
  parameter  H_BLANK = (H_FRONT+H_SYNC)+H_BACK;
  parameter  H_TOTAL = (H_ACT+(H_BACK+H_SYNC))+H_FRONT;
  parameter  V_FRONT = 11;
  parameter  V_SYNC = 1<<1;
  parameter  V_BACK = 31;
  parameter  V_ACT = 480;
  parameter  V_BLANK = (V_BACK+V_FRONT)+V_SYNC;
  parameter  V_TOTAL = V_FRONT+((V_ACT+V_BACK)+V_SYNC);
  reg  [9:0] h_cntr,v_cntr,current_x,current_y;
  reg  h_active,v_active,vga_hs,vga_vs;

  assign vga_blank = v_active & h_active;
  assign vga_clock = ~clk27;
  assign vga_r = r;
  assign vga_g = g;
  assign vga_b = b;
  assign request = (h_cntr >= H_BLANK) && 
                   ((v_cntr >= V_BLANK) && (v_cntr < V_TOTAL)) && (h_cntr < H_TOTAL);
  
  always @(posedge clk27)
      begin
        if (rst27) 
          begin
            h_cntr <= 0;
            v_cntr <= 0;
            vga_hs <= 1'b1;
            vga_vs <= 1'b1;
            current_x <= 0;
            current_y <= 0;
            h_active <= 1'b0;
            v_active <= 1'b0;
          end
        else 
          begin
            if (h_cntr != H_TOTAL) 
              begin
                h_cntr <= h_cntr+1'b1;
                if (h_active) current_x <= current_x+1'b1;
                  
                if (h_cntr == (H_BLANK+(0-1))) h_active <= 1'b1;
                  
              end
            else 
              begin
                h_cntr <= 0;
                h_active <= 1'b0;
                current_x <= 0;
              end
            if (h_cntr == ((0-1)+H_FRONT)) 
              begin
                vga_hs <= 1'b0;
              end
              
            if (h_cntr == ((0-1)+(H_FRONT+H_SYNC))) 
              begin
                vga_hs <= 1'b1;
                if (v_cntr != V_TOTAL) 
                  begin
                    v_cntr <= 1'b1+v_cntr;
                    if (v_active) current_y <= 1'b1+current_y;
                      
                    if (v_cntr == (V_BLANK+(0-1))) v_active <= 1'b1;
                      
                  end
                else 
                  begin
                    v_cntr <= 0;
                    current_y <= 0;
                    v_active <= 1'b0;
                  end
                if (v_cntr == (V_FRONT-1)) vga_vs <= 1'b0;
                  
                if (v_cntr == (V_SYNC+(V_FRONT-1))) vga_vs <= 1'b1;
                  
              end
              
          end
      end
endmodule

