
module PushButton_Debouncer  #(parameter  COUNTER_WIDTH = 16)
  (input  wire clk,
   input  wire PB,
   output reg PB_state,
   output wire PB_down,
   output wire PB_up);

  reg  PB_sync_0;

  
  always @(posedge clk)  PB_sync_0 <= PB;
  reg  PB_sync_1;

  
  always @(posedge clk)  PB_sync_1 <= PB_sync_0;
  reg  [COUNTER_WIDTH-1:0] PB_cnt;

  wire  PB_idle = PB_state == PB_sync_1;

  wire  PB_cnt_max = &PB_cnt;

  
  always @(posedge clk)
      if (PB_idle) PB_cnt <= 0;
      else 
        begin
          PB_cnt <= 16'd1+PB_cnt;
          if (PB_cnt_max) PB_state <= ~PB_state;
            
        end
  assign PB_down = PB_cnt_max & (~PB_idle & ~PB_state);
  assign PB_up = (PB_cnt_max & ~PB_idle) & PB_state;
endmodule

