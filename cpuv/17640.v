module at93c46d_spi # 
(
)
(
  input wire                      clk, 
  input wire [8-1:0]              cmd, 
  input wire [16-1:0]             data_in, 
  input wire                      start, 
  input wire                      dout, 
  output reg                      cs, 
  output reg                      sclk, 
  output reg                      din, 
  output reg [8-1:0]              cnt_sclk_out, 
  output reg [16-1:0]             data_out 
);
  reg start_next; 
  reg sclk_int; 
  reg [8-1:0] cmd_reg; 
  reg [16-1:0] data_in_reg; 
  reg [16-1:0] data_out_reg; 
  reg [7-1:0] cnt_clk  = 7'b0000000; 
  reg [5-1: 0] cnt_sclk = {(5){1'b0}}; 
  always @(posedge clk) begin
    start_next <= start; 
    if (!start_next && start) begin 
      cs <= 1'b1; 
      data_in_reg <= data_in; 
      cmd_reg <= cmd; 
    end
    if (cs == 1'b1) begin 
      cnt_clk <= cnt_clk + 1; 
      if (cnt_clk == 7'b0111111) begin 
        sclk <= 1'b0; 
        cnt_sclk_out <= cnt_sclk; 
        if (cs == 1'b1) begin 
          cnt_sclk <= cnt_sclk + 1; 
          if (cmd_reg[8-1:6] == 2'b10) begin 
          end
          else if (cmd_reg[8-1:6] == 2'b01 | cmd_reg[8-1:4] == 2'b0001) begin 
          end
          else begin 
          end
        end
      end
      if (cnt_clk == 7'b1111111) begin 
        sclk <= 1'b1; 
      end
    end else begin 
      sclk <= 1'b0; 
      cnt_clk  = 7'b0000000; 
    end
  end
endmodule