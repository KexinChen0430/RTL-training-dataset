
module color_position  #(parameter  THRESHOLD = 20, COLOR_WIDTH = 10, DISP_WIDTH = 11)
  (input  wire clk,
   input  wire aresetn,
   input  wire enable,
   input  wire enable_kalman,
   input  wire [COLOR_WIDTH-1:0] curr,
   input  wire [(0-1)+DISP_WIDTH:0] x_pos,
   input  wire [(0-1)+DISP_WIDTH:0] y_pos,
   input  wire [(0-1)+DISP_WIDTH:0] x_obj,
   input  wire [(0-1)+DISP_WIDTH:0] y_obj,
   input  wire [(0-1)+DISP_WIDTH:0] x_kalman,
   input  wire [(0-1)+DISP_WIDTH:0] y_kalman,
   output wire [COLOR_WIDTH-1:0] r_out,
   output wire [COLOR_WIDTH-1:0] g_out,
   output wire [COLOR_WIDTH-1:0] b_out);

  wire vga_is_object;
  wire [(0-1)+DISP_WIDTH:0] x_diff;
  wire [(0-1)+DISP_WIDTH:0] y_diff;
  wire vga_is_kalman;
  wire [(0-1)+DISP_WIDTH:0] x_diff2;
  wire [(0-1)+DISP_WIDTH:0] y_diff2;
  reg  [COLOR_WIDTH-1:0] int_r_out;
  reg  [COLOR_WIDTH-1:0] int_g_out;
  reg  [COLOR_WIDTH-1:0] int_b_out;

  assign r_out = int_r_out;
  assign g_out = int_g_out;
  assign b_out = int_b_out;
  assign x_diff = (x_pos > x_obj) ? (x_pos-x_obj) : (x_obj-x_pos);
  assign y_diff = (y_pos > y_obj) ? ((-y_obj)+y_pos) : (y_obj+(0-y_pos));
  assign vga_is_object = (y_diff < THRESHOLD) & (x_diff < THRESHOLD);
  assign x_diff2 = (x_pos > x_kalman) ? (x_pos-x_kalman) : (x_kalman+(-x_pos));
  assign y_diff2 = (y_pos > y_kalman) ? (y_pos-y_kalman) : ((0-y_pos)+y_kalman);
  assign vga_is_kalman = (y_diff2 < THRESHOLD) & (x_diff2 < THRESHOLD);
  
  always @(posedge clk or negedge aresetn)
      begin
        if (~aresetn) 
          begin
            int_r_out <= 'd0;
            int_g_out <= 'd0;
            int_b_out <= 'd0;
          end
        else if (vga_is_kalman & (enable_kalman & enable)) 
          begin
            int_r_out <= {COLOR_WIDTH{1'b0}};
            int_g_out <= {COLOR_WIDTH{1'b1}};
            int_b_out <= {COLOR_WIDTH{1'b0}};
          end
        else if (vga_is_object & enable) 
          begin
            int_r_out <= {COLOR_WIDTH{1'b1}};
            int_g_out <= {COLOR_WIDTH{1'b0}};
            int_b_out <= {COLOR_WIDTH{1'b0}};
          end
        else 
          begin
            int_r_out <= curr;
            int_g_out <= curr;
            int_b_out <= curr;
          end
      end
endmodule

