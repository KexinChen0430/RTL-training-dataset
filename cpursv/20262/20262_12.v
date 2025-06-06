
module LCD_control(input  wire clock,
                   input  wire tick,
                   input  wire reset_n,
                   output reg [9:0] x,
                   output reg [9:0] y,
                   output reg next_frame,
                   output reg hs_n,
                   output reg vs_n,
                   output reg data_enable);

  parameter  H_FRONT = 24;
  parameter  H_SYNC = 72;
  parameter  H_BACK = 96;
  parameter  H_ACT = 800;
  parameter  H_BLANK = (H_SYNC+H_FRONT)+H_BACK;
  parameter  H_TOTAL = H_ACT+((H_SYNC+H_FRONT)+H_BACK);
  parameter  V_FRONT = 3;
  parameter  V_SYNC = 10;
  parameter  V_BACK = 7;
  parameter  V_ACT = 480;
  parameter  V_BLANK = V_FRONT+(V_SYNC+V_BACK);
  parameter  V_TOTAL = V_ACT+(V_FRONT+(V_SYNC+V_BACK));
  reg  [10:0] h;
  reg  [10:0] v;
  wire  h_visible = h >= H_BLANK;
  wire  v_visible = v >= V_BLANK;
  wire [10:0]  h_normalized = h+(-H_BLANK);
  wire [10:0]  v_normalized = (0-V_BLANK)+v;

  
  always @(posedge clock)
      begin
        if (tick) 
          begin
            next_frame <= (v == V_FRONT) && (h == 0);
          end
          
      end
  
  always @(posedge clock or negedge reset_n)
      begin
        if (!reset_n) 
          begin
            h <= 0;
            v <= 0;
            hs_n <= 1;
            vs_n <= 1;
            x <= 0;
            y <= 0;
            data_enable <= 0;
          end
        else if (tick) 
          begin
            if (h < (H_TOTAL-1)) 
              begin
                h <= h+1'b1;
              end
            else 
              begin
                h <= 0;
                if (v < ((-1)+V_TOTAL)) 
                  begin
                    v <= v+1'b1;
                  end
                else 
                  begin
                    v <= 0;
                  end
                if (v == (V_FRONT+(-1))) 
                  begin
                    vs_n <= 1'b0;
                  end
                  
                if (v == ((-1)+(V_FRONT+V_SYNC))) 
                  begin
                    vs_n <= 1'b1;
                  end
                  
              end
            if (h == ((-1)+H_FRONT)) 
              begin
                hs_n <= 1'b0;
              end
              
            if (h == ((-1)+(H_SYNC+H_FRONT))) 
              begin
                hs_n <= 1'b1;
              end
              
            x <= h_visible ? h_normalized[9:0] : 10'h0;
            y <= v_visible ? v_normalized[9:0] : 10'h0;
            data_enable <= h_visible && v_visible;
          end
          
      end
endmodule

