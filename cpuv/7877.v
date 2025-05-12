module vga( 
  input wire          clk, 
  input wire          reset_n, 
  input wire          button0, 
  input wire          button1, 
  output wire [3 : 0] red, 
  output wire [3 : 0] green, 
  output wire [3 : 0] blue, 
  output wire         test_clk, 
  output wire         vsync, 
  output wire         hsync 
);
parameter RED_DEFAULT      = 4'hf;
parameter GREEN_DEFAULT    = 4'hf;
parameter BLUE_DEFAULT     = 4'hf;
parameter START_OF_LINE    = 11'h000;
parameter END_OF_LINE      = 11'h63e;
parameter END_OF_PIXELS    = 11'h57e;
parameter END_OF_SCREEN    = 11'h20c;
parameter START_OF_DISPLAY = 11'h021;
parameter END_OF_DISPLAY   = 11'h200;
parameter UPDATE_DELAY_MAX = 32'h002c4b40;
reg          vsync_reg;
reg          vsync_new;
reg          vsync_we;
reg          hsync_reg;
reg          hsync_new;
reg          hsync_we;
reg [3 : 0]  red_reg;
reg [3 : 0]  red_new;
reg          red_we;
reg [3 : 0]  green_reg;
reg [3 : 0]  green_new;
reg          green_we;
reg [3 : 0]  blue_reg;
reg [3 : 0]  blue_new;
reg          blue_we;
reg          button0_reg;
reg          button1_reg;
reg [31 : 0] delay_ctr_reg;
reg [31 : 0] delay_ctr_new;
reg          delay_ctr_we;
reg [10 : 0] row_cycle_ctr_reg;
reg [10 : 0] row_cycle_ctr_new;
reg          row_cycle_ctr_rst;
reg          row_cycle_ctr_inc;
reg          row_cycle_ctr_we;
reg [10 : 0] line_ctr_reg;
reg [10 : 0] line_ctr_new;
reg          line_ctr_rst;
reg          line_ctr_inc;
reg          line_ctr_we;
reg          test_clk_reg;
reg new_line;
assign red   = red_reg;
assign green = green_reg;
assign blue  = blue_reg;
assign hsync = hsync_reg;
assign vsync = vsync_reg;
assign test_clk = test_clk_reg;
always @ (posedge clk or negedge reset_n)
  begin
    if (!reset_n) 
      begin
        red_reg             <= RED_DEFAULT;
        green_reg           <= GREEN_DEFAULT;
        blue_reg            <= BLUE_DEFAULT;
        vsync_reg           <= 0;
        hsync_reg           <= 0;
        button0_reg         <= 0;
        button1_reg         <= 0;
        debug_delay_ctr_reg <= 32'h00000000;
        row_cycle_ctr_reg   <= 11'h000;
        line_ctr_reg        <= 11'h000;
        test_clk_reg        <= 0;
      end
    else 
      begin
        button0_reg  <= button0;
        button1_reg  <= button1;
        test_clk_reg <= ~test_clk_reg;
        if (delay_ctr_we) delay_ctr_reg <= delay_ctr_new;
        if (row_cycle_ctr_we) row_cycle_ctr_reg <= row_cycle_ctr_new;
        if (line_ctr_we) line_ctr_reg <= line_ctr_new;
        if (hsync_we) hsync_reg <= hsync_new;
        if (vsync_we) vsync_reg <= vsync_new;
        if (green_we) green_reg <= green_new;
        if (blue_we) blue_reg <= blue_new;
        if (red_we) red_reg <= red_new;
      end
  end
always @*
  begin : delay_ctr
    if (button1_reg)
      begin
        delay_ctr_we  = 1;
        delay_ctr_new = delay_ctr_reg + 32'h00000001;
        if (delay_ctr_reg == UPDATE_DELAY_MAX)
          begin
            delay_ctr_new = 32'h00000000;
          end
      end
  end
always @*
  begin : row_cycle_ctr
    row_cycle_ctr_new = 11'h000;
    row_cycle_ctr_we  = 0;
    if (row_cycle_ctr_rst)
      begin
        row_cycle_ctr_new = 11'h000;
        row_cycle_ctr_we  = 1;
      end
    if (row_cycle_ctr_inc)
      begin
        row_cycle_ctr_new = row_cycle_ctr_reg + 11'h001;
        row_cycle_ctr_we  = 1;
      end
  end
always @*
  begin : line_ctr
    line_ctr_new = 11'h000;
    line_ctr_we  = 0;
    if (line_ctr_rst)
      begin
        line_ctr_new = 11'h000;
        line_ctr_we  = 1;
      end
    if (line_ctr_inc)
      begin
        line_ctr_new = line_ctr_reg + 11'h001;
        line_ctr_we  = 1;
      end
  end
always @*
  begin : hsync_logic
    hsync_new         = 0;
    hsync_we          = 0;
    row_cycle_ctr_rst = 0;
    row_cycle_ctr_inc = 0;
    new_line          = 0;
    if (row_cycle_ctr_reg == END_OF_LINE)
      begin
        row_cycle_ctr_rst = 1;
        new_line          = 1;
      end
    else
      begin
        row_cycle_ctr_inc = 1;
      end
    if (row_cycle_ctr_reg == START_OF_LINE)
      begin
        hsync_new = 1;
        hsync_we  = 1;
      end
    if (row_cycle_ctr_reg == END_OF_PIXELS)
      begin
        hsync_new = 0;
        hsync_we  = 1;
      end
  end
always @*
  begin : vsync_logic
    vsync_new    = 0;
    vsync_we     = 0;
    line_ctr_rst = 0;
    line_ctr_inc = 0;
    if (new_line)
      begin
        if (line_ctr_reg == END_OF_SCREEN)
          begin
            line_ctr_rst = 1;
          end
        else
          begin
            line_ctr_inc = 1;
          end
      end
    if (line_ctr_reg == START_OF_DISPLAY)
      begin
        vsync_new = 1;
        vsync_we  = 1;
      end
    if (line_ctr_reg == END_OF_DISPLAY)
      begin
        vsync_new = 0;
        vsync_we  = 1;
      end
  end
always @*
  begin : rgb_update
    red_new   = 4'h0;
    red_we    = 0;
    green_new = 4'h0;
    green_we  = 0;
    blue_new  = 4'h0;
    blue_we   = 0;
    if (button1_reg && (debug_delay_ctr_reg == 32'h00000000))
      begin
        red_new   = red_reg + 4'h1;
        red_we    = 1;
        green_new = green_reg + 4'h3;
        green_we  = 1;
        blue_new  = blue_reg + 4'h5;
        blue_we   = 1;
      end
    if (button0_reg)
      begin
        red_new   = red_reg + 4'h1;
        red_we    = 1;
        green_new = green_reg + 4'h3;
        green_we  = 1;
        blue_new  = blue_reg + 4'h5;
        blue_we   = 1;
      end
  end
endmodule