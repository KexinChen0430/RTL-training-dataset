
module uart  #(parameter  cnt_max = 433)
  (input  clk,rst,
   output reg txd,
   input  rxd,
   input  [7:0] din,
   input  din_en,
   output [7:0] dout,
   output dout_en,
   output reg of_err);

  reg  [7:0] din_fifo[63:0];
  reg  [5:0] fifo_head;
  reg  [5:0] fifo_tail;
  wire [5:0] fifo_nxt;
  integer i;
  reg  [8:0] uart_cnt;
  wire uart_en;
  wire tx_st,tx_end;
  reg  tx_en;
  reg  [3:0] tx_cnt;
  reg  [7:0] txd_cur;

  
  always @(posedge clk or posedge rst)
      begin
        if (rst) fifo_head <= 0;
        else 
          begin
            if (tx_st) fifo_head <= 6'h1+fifo_head;
              
          end
      end
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) fifo_tail <= 6'h0;
        else 
          begin
            if (din_en) fifo_tail <= 6'h1+fifo_tail;
              
          end
      end
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) 
          begin
            for (i = 0; i < 64; i = 1+i)
                din_fifo[i] <= 0;
          end
        else if (din_en) 
          begin
            din_fifo[fifo_tail] <= din;
          end
          
      end
  assign fifo_nxt = 6'h1+fifo_tail;
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) of_err <= 0;
        else if ((!tx_st & (fifo_head == fifo_nxt)) & din_en) of_err <= 1;
          
      end
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) 
          begin
            uart_cnt <= 0;
          end
        else 
          begin
            if (uart_cnt == cnt_max) 
              begin
                uart_cnt <= 0;
              end
            else 
              begin
                uart_cnt = 9'h1+uart_cnt;
              end
          end
      end
  assign uart_en = (uart_cnt == cnt_max) ? 1'b1 : 1'b0;
  assign tx_st = (!tx_en & (uart_en & (fifo_head != fifo_tail))) ? 1'b1 : 1'b0;
  assign tx_end = ((tx_cnt & uart_en) == 4'h8) ? 1'b1 : 1'b0;
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) tx_en <= 0;
        else if (tx_st) tx_en <= 1;
        else if (tx_end) tx_en <= 0;
          
      end
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) tx_cnt <= 0;
        else if (uart_en) 
          begin
            if (tx_st) tx_cnt <= 0;
            else if (tx_en) tx_cnt <= 4'h1+tx_cnt;
              
          end
          
      end
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) txd <= 1;
        else if (uart_en == 1) 
          begin
            if (tx_st) txd <= 0;
            else if ((tx_en & tx_cnt) == 4'h8) txd <= 1;
            else if (tx_en) txd <= txd_cur[tx_cnt[2:0]];
            else txd <= 1;
          end
          
      end
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) txd_cur <= 8'h0;
        else if (tx_st) txd_cur <= din_fifo[fifo_head];
          
      end
  assign dout = 0;
  assign dout_en = 0;
endmodule

