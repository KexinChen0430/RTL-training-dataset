
module vga_sync(input  wire clock,
                input  wire aresetn,
                input  wire [2:0] color,
                output wire vga_clk,
                output reg [7:0] R,
                output reg [7:0] G,
                output reg [7:0] B,
                output reg h_sync,
                output reg v_sync,
                output wire blank_n,
                output wire sync_n);

  localparam  H_FRONT = 56;
  localparam  H_SYNC = 120;
  localparam  H_BACK = 64;
  localparam  H_ACT = 800;
  localparam  H_BLANK = H_SYNC+(H_BACK+H_FRONT);
  localparam  H_TOTAL = ((H_ACT+H_SYNC)+H_FRONT)+H_BACK;
  localparam  H_TOTAL_WIDTH = 10;
  localparam  V_FRONT = 37;
  localparam  V_SYNC = 6;
  localparam  V_BACK = 23;
  localparam  V_ACT = 600;
  localparam  V_BLANK = V_FRONT+(V_BACK+V_SYNC);
  localparam  V_TOTAL = ((V_BACK+V_SYNC)+V_ACT)+V_FRONT;
  localparam  V_TOTAL_WIDTH = 10;

  assign vga_clk = ~clock;
  reg  [(0-1)+H_TOTAL_WIDTH:0] hor_pos;

  reg  [V_TOTAL_WIDTH-1:0] ver_pos;

  
  always @(posedge clock)
      begin
        if (~aresetn) 
          begin
            hor_pos <= 'd0;
            h_sync <= 1'b0;
          end
        else 
          begin
            if (hor_pos < H_TOTAL) hor_pos <= 1+hor_pos;
            else hor_pos <= 0;
            if (hor_pos == (H_FRONT+(0-1))) h_sync <= 1'b1;
              
            if (hor_pos == ((H_FRONT+(0-1))+H_SYNC)) h_sync <= 1'b0;
              
          end
      end
  
  always @(posedge h_sync)
      begin
        if (~aresetn) 
          begin
            ver_pos <= 'd0;
            v_sync <= 1'b0;
          end
        else 
          begin
            if (ver_pos < V_TOTAL) ver_pos <= ver_pos+1;
            else ver_pos <= 0;
            if (ver_pos == (V_FRONT+(0-1))) v_sync <= 1'b1;
              
            if (ver_pos == (((0-1)+V_SYNC)+V_FRONT)) v_sync <= 1'b0;
              
          end
      end
  
  always @(posedge clock)
      begin
        if (~aresetn) 
          begin
            R <= 8'd0;
            B <= 8'd0;
            G <= 8'd0;
          end
        else if ((hor_pos < H_BLANK) | (ver_pos < V_BLANK)) 
          begin
            R <= 8'd0;
            B <= 8'd0;
            G <= 8'd0;
          end
        else 
          begin
            if (color == 3'b100) 
              begin
                R <= hor_pos[7:0];
                G <= ver_pos[7:0];
                B <= hor_pos[7:0];
              end
            else if (color == 3'b110) 
              begin
                R <= 8'd255;
                G <= 8'd0;
                B <= 8'd0;
              end
            else if (color == 3'b101) 
              begin
                R <= 8'd0;
                G <= 8'd255;
                B <= 8'd0;
              end
            else if (color == 3'b011) 
              begin
                R <= 8'd0;
                G <= 8'd0;
                B <= 8'd255;
              end
            else 
              begin
                R <= R;
                G <= G;
                B <= B;
              end
          end
      end
  assign blank_n = ~((ver_pos < V_BLANK) || (hor_pos < H_BLANK));
  assign sync_n = 1'b1;
endmodule

