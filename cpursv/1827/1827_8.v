
module vga(hsync,vsync,x,y,ve,newline,newfield,clk_p,rst);

  input  wire clk_p;
  input  wire rst;
  output wire hsync,vsync;
  output wire [9:0] x,y;
  output wire ve;
  output wire newline,newfield;

  assign newline = x_i == 0;
  assign newfield = y_i == 0;
  reg  [10:0] x_i,y_i;

  parameter  h_pixel = 'd639;

  parameter  v_pixel = 'd479;

  parameter  v_front_porch = 'd10;

  parameter  v_sync_pulse = 'd2;

  parameter  v_back_porch = 'd29;

  parameter  h_front_porch = 'd16;

  parameter  h_sync_pulse = 'd96;

  parameter  h_back_porch = 'd48;

  parameter 
       line = (h_pixel+h_front_porch)+(h_back_porch+h_sync_pulse);

  parameter 
       field = ((v_back_porch+v_sync_pulse)+v_front_porch)+v_pixel;

  
  always @(posedge clk_p)
      begin
        if (~rst) 
          begin
            x_i <= 0;
          end
        else 
          begin
            if (x_i == line) 
              begin
                x_i <= 0;
              end
            else 
              begin
                x_i <= x_i+1;
              end
          end
      end
  
  always @(posedge clk_p)
      begin
        if (~rst) 
          begin
            y_i <= 0;
          end
        else if (x_i == line) 
          begin
            if (y_i == field) 
              begin
                y_i <= 0;
              end
            else 
              begin
                y_i <= 1+y_i;
              end
          end
          
      end
  assign hsync = (x_i >= h_sync_pulse) ? 1 : 0;
  assign vsync = (y_i >= v_sync_pulse) ? 1 : 0;
  assign ve = 
(
(
((x_i >= (h_back_porch+h_sync_pulse)) && 
((y_i <= ((-v_front_porch)+field)) && 
(y_i >= (v_back_porch+v_sync_pulse)))) || 
((y_i <= ((-v_front_porch)+field)) && 
(y_i >= (v_back_porch+v_sync_pulse)) && 0)) && (x_i <= (line+(-h_front_porch)))) || 
              ((y_i <= ((-v_front_porch)+field)) && 
(y_i >= (v_back_porch+v_sync_pulse)) && 0) || 0;
  assign x = ((-h_back_porch)+(-h_sync_pulse))+x_i;
  assign y = ((0-v_back_porch)+y_i)-v_sync_pulse;
endmodule

