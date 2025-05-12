module
parameter m1_idle = 0; 
parameter m1_start = 1; 
parameter m1_shift = 3; 
parameter m1_over_run = 2; 
parameter m1_under_run = 4; 
parameter m1_all_low = 5; 
parameter m1_extra_1 = 6; 
parameter m1_extra_2 = 7; 
parameter m2_data_ready_flag = 1; 
parameter m2_data_ready_ack = 0; 
input clk; 
input rx_clk; 
input reset; 
input rxd; 
input read; 
output [DATA_BITS_PP-1:0] data; 
output data_ready; 
output error_over_run; 
output error_under_run; 
output error_all_low; 
reg [DATA_BITS_PP-1:0] data; 
reg data_ready; 
reg error_over_run; 
reg error_under_run; 
reg error_all_low; 
`define TOTAL_BITS START_BITS_PP + DATA_BITS_PP + STOP_BITS_PP 
wire word_xfer_l; 
wire mid_bit_l; 
wire start_bit_l; 
wire stop_bit_l; 
wire all_low_l; 
reg [3:0] intrabit_count_l; 
reg [`TOTAL_BITS-1:0] q; 
reg shifter_preset; 
reg [2:0] m1_state; 
reg [2:0] m1_next_state; 
reg m2_state; 
reg m2_next_state; 
always @(posedge clk)
begin : m1_state_register
  if (reset) m1_state <= m1_idle; 
  else m1_state <= m1_next_state; 
end
always @(m1_state
         or reset
         or rxd
         or mid_bit_l
         or all_low_l
         or start_bit_l
         or stop_bit_l
         )
begin : m1_state_logic
  shifter_preset <= 0;
  error_over_run <= 0;
  error_under_run <= 0;
  error_all_low <= 0;
  case (m1_state)
    m1_idle :
      begin
        shifter_preset <= 1'b1; 
        if (~rxd) m1_next_state <= m1_start; 
        else m1_next_state <= m1_idle; 
      end
    m1_start :
      begin
        if (~rxd && mid_bit_l) m1_next_state <= m1_shift; 
        else if (rxd && mid_bit_l) m1_next_state <= m1_under_run; 
        else m1_next_state <= m1_start; 
      end
    m1_shift :
      begin
        if (all_low_l) m1_next_state <= m1_all_low; 
        else if (~start_bit_l && ~stop_bit_l) m1_next_state <= m1_over_run; 
        else if (~start_bit_l && stop_bit_l) m1_next_state <= m1_idle; 
        else m1_next_state <= m1_shift; 
      end
    m1_over_run :
      begin
        error_over_run <= 1; 
        shifter_preset <= 1'b1; 
        if (reset) m1_next_state <= m1_idle; 
        else m1_next_state <= m1_over_run; 
      end
    m1_under_run :
      begin
        error_under_run <= 1; 
        shifter_preset <= 1'b1; 
        if (reset) m1_next_state <= m1_idle; 
        else m1_next_state <= m1_under_run; 
      end
    m1_all_low :
      begin
        error_all_low <= 1; 
        shifter_preset <= 1'b1; 
        if (reset) m1_next_state <= m1_idle; 
        else m1_next_state <= m1_all_low; 
      end
    default : m1_next_state <= m1_idle; 
  endcase
end
assign word_xfer_l = ((m1_state == m1_shift) && ~start_bit_l && stop_bit_l);
always @(posedge clk)
begin : m2_state_register
  if (reset) m2_state <= m2_data_ready_ack; 
  else m2_state <= m2_next_state; 
end
always @(m2_state or word_xfer_l or read)
begin : m2_state_logic
  case (m2_state)
    m2_data_ready_ack:
          begin
            data_ready <= 1'b0; 
            if (word_xfer_l) m2_next_state <= m2_data_ready_flag; 
            else m2_next_state <= m2_data_ready_ack; 
          end
    m2_data_ready_flag:
          begin
            data_ready <= 1'b1; 
            if (read) m2_next_state <= m2_data_ready_ack; 
            else m2_next_state <= m2_data_ready_flag; 
          end
    default : m2_next_state <= m2_data_ready_ack; 
  endcase
end
always @(posedge clk)
begin
  if (shifter_preset) intrabit_count_l <= 0; 
  else if (rx_clk)
  begin
    if (intrabit_count_l == (CLOCK_FACTOR_PP-1)) intrabit_count_l <= 0; 
    else intrabit_count_l <= intrabit_count_l + 1; 
  end
end
assign mid_bit_l = ((intrabit_count_l==(CLOCK_FACTOR_PP / 2)) && rx_clk);
always @(posedge clk)
begin : rxd_shifter
  if (shifter_preset) q <= -1; 
  else if (mid_bit_l) q <= {rxd,q[`TOTAL_BITS-1:1]}; 
end
assign start_bit_l = q[0]; 
assign stop_bit_l = q[`TOTAL_BITS-1]; 
assign all_low_l = ~(| q); 
always @(posedge clk)
begin : rxd_output
  if (reset) data <= 0; 
  else if (word_xfer_l)
    data <= q[START_BITS_PP+DATA_BITS_PP-1:START_BITS_PP]; 
end
endmodule