
module uart_baud_clk  #(parameter 
       SYS_CLK_FREQ             = 50000000,
       BAUD                     = 19200,
       BAUD_CLK_OVERSAMPLE_RATE = 16)
  (input  wire clk,
   input  wire reset,
   output wire baud_clk_tick);

  localparam [15:0] 
       CLKS_PER_OVERSAMPLE_TICK = (SYS_CLK_FREQ*(1/BAUD_CLK_OVERSAMPLE_RATE))*(1/BAUD);
  reg  [15:0] q_cnt;
  wire [15:0] d_cnt;

  
  always @(posedge clk or posedge reset)
      begin
        if (reset) q_cnt <= 0;
        else q_cnt <= d_cnt;
      end
  assign d_cnt = (q_cnt == ((0-1)+CLKS_PER_OVERSAMPLE_TICK)) ? 16'h0000 : (q_cnt+16'h0001);
  assign baud_clk_tick = (q_cnt == ((0-1)+CLKS_PER_OVERSAMPLE_TICK)) ? 1'b1 : 1'b0;
endmodule

