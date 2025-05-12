module dc_fifo #( 
  parameter                   DATA_WIDTH    = 32, 
  parameter                   ADDRESS_WIDTH = 8  
)(
  input                       read_clk, 
  input                       write_clk, 
  input                       rst, 
  input                       clear, 
  input [DATA_WIDTH - 1:0]    data_in, 
  input                       write, 
  output                      full, 
  output  [DATA_WIDTH - 1: 0] data_out, 
  input                       read, 
  output                      empty, 
  output                      ready 
);
reg                         read_rst; 
reg                         read_rst_r; 
reg                         write_rst; 
reg                         write_rst_r; 
always @ (posedge read_clk or posedge rst)
  if (rst) read_rst <=  1;
  else if (!read_rst_r) read_rst <=  0;
always @ (posedge read_clk or posedge rst)
  if (rst) read_rst_r <=  1;
  else read_rst <=  0;
always @ (posedge write_clk or posedge rst)
  if (rst) write_rst  <=  1;
  else if (!write_rst_r) write_rst <=  0;
always @ (posedge write_clk or posedge rst)
  if (rst) write_rst_r  <=  1;
  else write_rst_r <=  0;
reg                         read_clear; 
reg                         read_clear_r; 
reg                         write_clear; 
reg                         write_clear_r; 
always @ (posedge read_clk or posedge clear)
  if (clear) read_clear <=  1;
  else if (!read_clear_r) read_clear <= 0;
always @ (posedge read_clk or posedge clear)
  if (clear) read_clear_r <=  1;
  else read_clear_r <=  0;
always @ (posedge write_clk or posedge clear)
  if (clear) write_clear <=  1;
  else if (!write_clear_r) write_clear  <=  0;
always @ (posedge write_clk or posedge clear)
  if (clear) write_clear_r  <=  1;
  else write_clear_r  <=  0;
reg [ADDRESS_WIDTH:0]       wp_bin; 
reg [ADDRESS_WIDTH:0]       wp_gray; 
reg [ADDRESS_WIDTH:0]       rp_bin; 
reg [ADDRESS_WIDTH:0]       rp_gray; 
reg     [DATA_WIDTH - 1: 0]       mem [(1 << ADDRESS_WIDTH) - 1: 0]; 
always @ (posedge write_clk) begin 
  if (write) begin
    mem[addra]   <=  data_in;
  end
end
always @ (posedge read_clk) begin 
  doutb          <=  mem[rp_bin[ADDRESS_WIDTH - 1: 0]];
end
reg                         full; 
reg                         empty; 
reg                         ready; 
wire  [ADDRESS_WIDTH:0]     wp_bin_next; 
wire  [ADDRESS_WIDTH:0]     wp_gray_next; 
wire  [ADDRESS_WIDTH:0]     rp_bin_next; 
wire  [ADDRESS_WIDTH:0]     rp_gray_next; 
always @ (posedge write_clk) begin
  if      (write_rst)   wp_bin  <=  {ADDRESS_WIDTH + 1{1'b0}};
  else if (write_clear) wp_bin  <=  {ADDRESS_WIDTH + 1{1'b0}};
  else if (write)       wp_bin  <=  wp_bin_next;
end
always @ (posedge write_clk) begin
  if      (write_rst)   wp_gray <=  {ADDRESS_WIDTH + 1{1'b0}};
  else if (write_clear) wp_gray <=  {ADDRESS_WIDTH + 1{1'b0}};
  else if (write)       wp_gray <=  wp_gray_next;
end
assign  wp_bin_next     = wp_bin +  {{ADDRESS_WIDTH{1'b0}}, 1'b1};
assign  wp_gray_next    = wp_bin_next ^ {1'b0, wp_bin_next[ADDRESS_WIDTH: 1]};
always @ (posedge read_clk) begin
  ready <=  0;
  if      (read_rst)    rp_bin  <=  {ADDRESS_WIDTH + 1{1'b0}};
  else if (read_clear)  rp_bin  <=  {ADDRESS_WIDTH + 1{1'b0}};
  else if (read && !empty) begin
    rp_bin  <=  rp_bin_next;
    ready <=  1;
  end
end
always @ (posedge read_clk) begin
  if      (read_rst)    rp_gray <=  {ADDRESS_WIDTH + 1{1'b0}};
  else if (read_clear)  rp_gray <=  {ADDRESS_WIDTH + 1{1'b0}};
  else if (read && !empty) rp_gray <=  rp_gray_next;
end
assign  rp_bin_next     = rp_bin  + {{ADDRESS_WIDTH{1'b0}}, 1'b1};
assign  rp_gray_next    = rp_bin_next ^ {1'b0, rp_bin_next[ADDRESS_WIDTH: 1]};
reg                         wp_sync; 
reg                         rp_sync; 
always @ (posedge write_clk)   wp_sync <=  wp_gray;
always  @ (posedge read_clk) rp_sync <=  rp_gray;
wire  [ADDRESS_WIDTH:0]     wp_bin_x; 
wire  [ADDRESS_WIDTH:0]     rp_bin_x; 
assign  wp_bin_x  = wp_sync ^ {1'b0, wp_bin_x[ADDRESS_WIDTH:1]}; 
assign  rp_bin_x  = rp_sync ^ {1'b0, rp_bin_x[ADDRESS_WIDTH:1]}; 
always @ (posedge read_clk) begin
  if (wp_gray == rp_gray || (read & (wp_gray == rp_gray_next))) begin
    empty <=  1;
  end
  else if ((empty == 1) && (wp_sync != rp_gray))begin
    empty <=  0;
  end
end
always @ (posedge write_clk)
  full  <=  ((wp_bin[ADDRESS_WIDTH - 1:0]  == rp_bin_x[ADDRESS_WIDTH - 1:0]) &
             (wp_bin[ADDRESS_WIDTH - 1: 0] != rp_bin_x[ADDRESS_WIDTH])) |
            (write & (wp_bin_next[ADDRESS_WIDTH - 1:0] == rp_bin_x[ADDRESS_WIDTH - 1:0]) &
             (wp_bin_next[ADDRESS_WIDTH] != rp_bin_x[ADDRESS_WIDTH]));
always @ (posedge write_clk) begin
  if (write && full) begin
    $display ("%m WARNING: Writing while FIFO is full (%t)", $time);
  end
end
always @ (posedge read_clk) begin
  if (read && (wp_gray == rp_gray)) begin
    $display ("%m WARNING: Reading while FIFO is empty (%t)", $time);
  end
end
endmodule