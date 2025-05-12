module uart_0_tx (
  baud_divisor, 
  begintransfer, 
  clk, 
  clk_en, 
  do_force_break, 
  reset_n, 
  status_wr_strobe, 
  tx_data, 
  tx_wr_strobe, 
  tx_overrun, 
  tx_ready, 
  tx_shift_empty, 
  txd 
)
;
output tx_overrun; 
output tx_ready; 
output tx_shift_empty; 
output txd; 
input [8:0] baud_divisor; 
input begintransfer; 
input clk; 
input clk_en; 
input do_force_break; 
input reset_n; 
input status_wr_strobe; 
input [7:0] tx_data; 
input tx_wr_strobe; 
reg baud_clk_en; 
reg [8:0] baud_rate_counter; 
wire baud_rate_counter_is_zero; 
reg do_load_shifter; 
wire do_shift; 
reg pre_txd; 
wire shift_done; 
wire [9:0] tx_load_val; 
reg tx_overrun; 
reg tx_ready; 
reg tx_shift_empty; 
wire tx_shift_reg_out; 
wire [9:0] tx_shift_register_contents; 
wire tx_wr_strobe_onset; 
reg txd; 
wire [9:0] unxshiftxtx_shift_register_contentsxtx_shift_reg_outxx5_in; 
reg [9:0] unxshiftxtx_shift_register_contentsxtx_shift_reg_outxx5_out; 