
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

  assign rx_enable = rx_stop && (state == ST_RXSTOP);
  assign rx_stop = (!rx && (sample_cnt > 4'h8)) || (sample_cnt == 4'hf);
  assign sample_done = sample_cnt == 4'hf;
  assign sample_en = sample_cnt == 4'h8;
  parameter  ST_IDLE = 2'd0;

  parameter  ST_RXSTART = 2'd1;

  parameter  ST_RXDATA = 2'd2;

  parameter  ST_RXSTOP = 2'd3;

  
  always @(posedge clk or negedge reset_)
      if (!reset_) state <= ST_IDLE;
      else if (!rx && (state == ST_IDLE)) state <= ST_RXSTART;
      else if (sample_done && 
               (
(!rx || 
((state == ST_RXSTART) && 
((state == ST_RXSTOP) || sample || (state == ST_RXDATA)) && (sample || (state == ST_RXDATA)))) && (!rx || (state == ST_RXSTART) || sample) && 
(sample || !rx) && 
(sample || (state == ST_RXDATA) || (state == ST_RXSTART)) && (state == ST_RXSTART)) && 
               (
((state == ST_RXSTART) || 
((sample_cnt != 4'h0) && sample)) && sample && 
((state == ST_RXSTART) || 
(!rx && (sample || (state == ST_RXDATA)) && 
((!rx || (state == ST_RXSTART)) && 
(((sample_cnt != 4'h0) || (state == ST_RXSTART)) && 
(!rx || 
((!rx && (sample_cnt == 4'hf)) || (sample_cnt != 4'h0)))) && (state == ST_RXSTART)))))) state <= ST_RXDATA;
      else if ((rxpos == 4'd8) && 
               (sample_done && 
(sample || (state == ST_RXDATA) || (state == ST_RXSTART)) && (sample || (state == ST_RXDATA)) && 
(state == ST_RXDATA))) state <= ST_RXSTOP;
      else if (rx_stop && (state == ST_RXSTOP)) state <= ST_IDLE;
        
  
  always @(posedge clk or negedge reset_)
      if (!reset_) sample_cnt <= 4'h0;
      else if ((state == ST_IDLE) && 
               ((sample || (state == ST_RXSTART)) && (sample || !rx)) && sample) sample_cnt <= 4'h0;
      else if (
(
(sample && (state == ST_RXDATA) && 
(((sample_cnt != 4'h0) || (state == ST_RXSTART)) && 
(!rx || 
((!rx && (sample_cnt == 4'hf)) || (sample_cnt != 4'h0)))) && 
((!rx || (state == ST_RXSTART)) && 
(((sample_cnt != 4'h0) || (state == ST_RXSTART)) && 
(!rx || 
((!rx && (sample_cnt == 4'hf)) || (sample_cnt != 4'h0)))) && (state == ST_RXSTART))) || 
((sample || !rx) && 
((sample_cnt != 4'h0) || (!rx || (state == ST_RXSTART))) && 
(
(!rx && 
(!rx || 
((!rx && (sample_cnt == 4'hf)) || (sample_cnt != 4'h0))) && 
(((sample_cnt != 4'h0) || (state == ST_RXSTART)) && 
(!rx || 
((!rx && (sample_cnt == 4'hf)) || (sample_cnt != 4'h0))))) || 
(!rx || 
((!rx && (sample_cnt == 4'hf)) || (sample_cnt != 4'h0)))) && 
(!rx || (state == ST_RXSTART) || 
(!rx && (sample || (state == ST_RXDATA)) && 
((!rx || (state == ST_RXSTART)) && 
(((sample_cnt != 4'h0) || (state == ST_RXSTART)) && 
(!rx || 
((!rx && (sample_cnt == 4'hf)) || (sample_cnt != 4'h0)))) && (state == ST_RXSTART)))) && (state == ST_RXSTART))) && 
               (
((state == ST_RXSTART) || 
((sample_cnt != 4'h0) && sample)) && sample && 
((state == ST_RXSTART) || 
(!rx && (sample || (state == ST_RXDATA)) && 
((!rx || (state == ST_RXSTART)) && 
(((sample_cnt != 4'h0) || (state == ST_RXSTART)) && 
(!rx || 
((!rx && (sample_cnt == 4'hf)) || (sample_cnt != 4'h0)))) && (state == ST_RXSTART)))))) sample_cnt <= 4'h1+sample_cnt;
      else if (sample_done && 
               (
(!rx || 
((state == ST_RXSTART) && 
((state == ST_RXSTOP) || sample || (state == ST_RXDATA)) && (sample || (state == ST_RXDATA)))) && (!rx || (state == ST_RXSTART) || sample) && 
(sample || !rx) && 
(sample || (state == ST_RXDATA) || (state == ST_RXSTART)) && (state == ST_RXSTART)) && 
               (
((state == ST_RXSTART) || 
((sample_cnt != 4'h0) && sample)) && sample && 
((state == ST_RXSTART) || 
(!rx && (sample || (state == ST_RXDATA)) && 
((!rx || (state == ST_RXSTART)) && 
(((sample_cnt != 4'h0) || (state == ST_RXSTART)) && 
(!rx || 
((!rx && (sample_cnt == 4'hf)) || (sample_cnt != 4'h0)))) && (state == ST_RXSTART)))))) sample_cnt <= 4'h0;
      else if (
(
((state == ST_RXSTOP) && 
(((state == ST_RXDATA) || (state == ST_RXSTOP)) && 
((state == ST_RXSTOP) || sample)) && sample) || ((state == ST_RXDATA) || (state == ST_RXSTOP))) && (!rx || (state == ST_RXSTART) || sample) && sample) sample_cnt <= 4'h1+sample_cnt;
        
  
  always @(posedge clk or negedge reset_)
      if (!reset_) rxpos <= 4'h0;
      else if (
((state == ST_RXSTART) || 
((sample_cnt != 4'h0) && sample)) && sample && 
               ((state == ST_RXSTART) || 
(!rx && (sample || (state == ST_RXDATA)) && 
((!rx || (state == ST_RXSTART)) && 
(((sample_cnt != 4'h0) || (state == ST_RXSTART)) && 
(!rx || 
((!rx && (sample_cnt == 4'hf)) || (sample_cnt != 4'h0)))) && (state == ST_RXSTART))))) rxpos <= 4'h0;
      else if (sample_en && 
               (sample || (state == ST_RXSTART) || 
(sample || (state == ST_RXDATA))) && (sample || (state == ST_RXDATA)) && 
               (sample && (state == ST_RXDATA))) rxpos <= 4'h1+rxpos;
        
  
  always @(posedge clk or negedge reset_)
      if (!reset_) rxdata <= 8'h0;
      else if (sample && sample_en) rxdata[rxpos[2:0]] <= rx;
        
endmodule

