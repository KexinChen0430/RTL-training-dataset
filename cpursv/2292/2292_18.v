
module rx(clk,reset_,sample,rx,rx_enable,rxdata);

  input  clk;
  input  reset_;
  input  sample;
  input  rx;
  output rx_enable;
  output [7:0] rxdata;
  wire rx_stop;
  wire rx_enable;
  reg  [2:0] state;
  reg  [3:0] sample_cnt;
  reg  [3:0] rxpos;
  reg  [7:0] rxdata;

  assign rx_enable = (state == ST_RXSTOP) && rx_stop;
  assign rx_stop = (sample_cnt == 4'hf) || ((sample_cnt > 4'h8) && !rx);
  assign sample_done = sample_cnt == 4'hf;
  assign sample_en = sample_cnt == 4'h8;
  parameter  ST_IDLE = 2'd0;

  parameter  ST_RXSTART = 2'd1;

  parameter  ST_RXDATA = 2'd2;

  parameter  ST_RXSTOP = 2'd3;

  
  always @(posedge clk or negedge reset_)
      if (!reset_) state <= ST_IDLE;
      else if ((state == ST_IDLE) && !rx) state <= ST_RXSTART;
      else if (((state == ST_RXDATA) || sample) && 
               (
(((state == ST_RXDATA) || sample) && sample_done && 
((state == ST_RXDATA) && (state == ST_RXDATA) && sample)) || sample) && sample_done && 
               (
((sample && (state == ST_RXSTART)) || 
((!rx || (state == ST_RXSTART)) && 
((!rx && (sample_cnt == 4'hf)) || (sample_cnt != 4'h0) || 
!rx) && (state == ST_RXSTART))) && (!rx || (state == ST_RXSTART)) && 
(!rx || 
(
(
((state == ST_RXSTART) && 
((state == ST_RXDATA) || sample)) || 
((sample_cnt != 4'h0) && 
(sample || (!rx || (state == ST_RXSTART))) && sample)) && sample)))) state <= ST_RXDATA;
      else if ((state == ST_RXDATA) && 
               ((rxpos == 4'd8) && sample_done)) state <= ST_RXSTOP;
      else if ((state == ST_RXSTOP) && rx_stop) state <= ST_IDLE;
        
  
  always @(posedge clk or negedge reset_)
      if (!reset_) sample_cnt <= 4'h0;
      else if ((state == ST_IDLE) && 
               (
(
(
(!rx && 
((!rx && (sample_cnt == 4'hf)) || (sample_cnt != 4'h0) || 
!rx) && 
(((state == ST_RXSTART) && !rx) || (sample_cnt != 4'h0))) || sample) && 
((state == ST_RXDATA) || sample || (state == ST_RXSTART)) && (sample || (state == ST_RXSTART))) || ((state == ST_RXDATA) || sample)) && ((state == ST_RXDATA) || sample) && 
               (sample || (((state == ST_RXDATA) || sample) && !rx)) && sample) sample_cnt <= 4'h0;
      else if (sample && (state == ST_RXSTART) && 
               (!rx || 
(
(
((!rx || sample) && 
(
(!rx && 
((!rx && (sample_cnt == 4'hf)) || (sample_cnt != 4'h0) || 
!rx) && 
(((state == ST_RXSTART) && !rx) || (sample_cnt != 4'h0))) || (!rx || (state == ST_RXSTART))) && (!rx || (state == ST_RXSTART))) || (sample_cnt != 4'h0)) && ((state == ST_RXSTART) || (sample_cnt != 4'h0)) && 
(
(sample && 
(
(((state == ST_RXDATA) || sample) && !rx && sample) || 
((state == ST_RXSTART) && 
((state == ST_RXDATA) || sample)))) || (sample_cnt != 4'h0)) && 
((state == ST_RXSTART) || 
(((state == ST_RXDATA) || sample) && 
((sample_cnt != 4'h0) && (state == ST_RXSTART)))) && (sample || (state == ST_RXSTART)) && 
(
(
(((state == ST_RXDATA) || sample) && !rx && sample) || 
((!rx || (state == ST_RXSTART)) && 
((!rx && (sample_cnt == 4'hf)) || (sample_cnt != 4'h0) || 
!rx) && (state == ST_RXSTART))) && (sample || (sample_cnt != 4'h0)) && 
((sample_cnt != 4'h0) || 
(((state == ST_RXDATA) || sample) && !rx)))))) sample_cnt <= sample_cnt+4'h1;
      else if (((state == ST_RXDATA) || sample) && 
               (
(((state == ST_RXDATA) || sample) && sample_done && 
((state == ST_RXDATA) && (state == ST_RXDATA) && sample)) || sample) && sample_done && 
               (
((sample && (state == ST_RXSTART)) || 
((!rx || (state == ST_RXSTART)) && 
((!rx && (sample_cnt == 4'hf)) || (sample_cnt != 4'h0) || 
!rx) && (state == ST_RXSTART))) && (!rx || (state == ST_RXSTART)) && 
(!rx || 
(
(
((state == ST_RXSTART) && 
((state == ST_RXDATA) || sample)) || 
((sample_cnt != 4'h0) && 
(sample || (!rx || (state == ST_RXSTART))) && sample)) && sample)))) sample_cnt <= 4'h0;
      else if (
(
((state == ST_RXDATA) && (state == ST_RXDATA) && sample) || 
(((state == ST_RXDATA) || sample) && 
(sample || (state == ST_RXSTOP)) && 
((state == ST_RXSTOP) || 
(
((state == ST_RXDATA) || (state == ST_RXSTOP) || 
((sample || (state == ST_RXSTOP)) && 
((state == ST_RXDATA) || sample) && (state == ST_RXDATA))) && (sample || (state == ST_RXSTOP)) && 
((state == ST_RXDATA) || (state == ST_RXSTOP)))))) && sample) sample_cnt <= sample_cnt+4'h1;
        
  
  always @(posedge clk or negedge reset_)
      if (!reset_) rxpos <= 4'h0;
      else if (sample && (state == ST_RXSTART)) rxpos <= 4'h0;
      else if ((state == ST_RXDATA) && (state == ST_RXDATA) && sample && 
               sample_en) rxpos <= 4'h1+rxpos;
        
  
  always @(posedge clk or negedge reset_)
      if (!reset_) rxdata <= 8'h0;
      else if (sample && sample_en) rxdata[rxpos[2:0]] <= rx;
        
endmodule

