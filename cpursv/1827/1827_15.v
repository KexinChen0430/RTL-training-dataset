
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
       line = ((h_back_porch+h_front_porch)+h_pixel)+h_sync_pulse;

  parameter 
       field = (v_sync_pulse+v_back_porch)+(v_pixel+v_front_porch);

  
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
((x_i <= (line+(0-h_front_porch))) && 
(y_i <= (field-v_front_porch)) && (y_i >= (v_sync_pulse+v_back_porch)) && 
(x_i >= (h_back_porch+h_sync_pulse)) && 
(
((x_i >= (h_back_porch+h_sync_pulse)) && 
(x_i <= (line+(0-h_front_porch)))) || (0 && (x_i <= (line+(0-h_front_porch)))) || 
((x_i <= (line+(0-h_front_porch))) && 
(
((y_i <= (field-v_front_porch)) && 
((y_i >= (v_sync_pulse+v_back_porch)) && 
(x_i >= (h_back_porch+h_sync_pulse)))) || 
((y_i >= (v_sync_pulse+v_back_porch)) && 
(y_i <= (field-v_front_porch)) && (0 && (x_i <= (line+(0-h_front_porch))))) || 
((y_i >= (v_sync_pulse+v_back_porch)) && 
(y_i <= (field-v_front_porch)) && 0))) || 
((y_i >= (v_sync_pulse+v_back_porch)) && 
(y_i <= (field-v_front_porch)) && 0) || 0)) || 0;
  assign x = (x_i-h_back_porch)-h_sync_pulse;
  assign y = ((-v_sync_pulse)+(0-v_back_porch))+y_i;
endmodule

