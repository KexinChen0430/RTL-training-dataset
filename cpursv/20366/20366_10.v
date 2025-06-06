
module tx(clk,reset_,baud,txdata,tx_enable,tx_ready,tx);

  input  clk;
  input  reset_;
  input  baud;
  input  [7:0] txdata;
  input  tx_enable;
  output tx_ready;
  output tx;
  reg  tx;
  reg  [1:0] state;
  reg  [7:0] txdata_sampled;
  reg  [2:0] txpos;
  parameter  ST_IDLE = 2'd0;
  parameter  ST_TXSTART = 2'd1;
  parameter  ST_TXDATA = 2'd2;
  parameter  ST_TXSTOP = 2'd3;

  assign tx_ready = state == ST_IDLE;
  
  always @(posedge clk or negedge reset_)
      if (!reset_) state <= ST_IDLE;
      else if (tx_enable && (state == ST_IDLE)) state <= ST_TXSTART;
      else if ((state == ST_TXSTART) && baud) state <= ST_TXDATA;
      else if ((txpos == 3'd7) && baud && (state == ST_TXDATA)) state <= ST_TXSTOP;
      else if ((state == ST_TXSTOP) && baud) state <= ST_IDLE;
        
  
  always @(posedge clk or negedge reset_)
      if (!reset_) tx <= 1'b1;
      else if ((state == ST_TXSTART) && baud) tx <= 1'b0;
      else if (baud && (state == ST_TXDATA)) tx <= txdata_sampled[txpos];
      else if ((state == ST_TXSTOP) && baud) tx <= 1'b1;
        
  
  always @(posedge clk or negedge reset_)
      if (!reset_) txpos <= 3'd0;
      else if (state == ST_IDLE) txpos <= 3'd0;
      else if (baud && (state == ST_TXDATA)) txpos <= 3'd1+txpos;
        
  
  always @(posedge clk or negedge reset_)
      if (!reset_) txdata_sampled <= 8'h0;
      else if (tx_ready && tx_enable) txdata_sampled <= txdata;
        
endmodule

