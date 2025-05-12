
module limbus_timer_0(address,chipselect,clk,reset_n,write_n,writedata,irq,
                      readdata);

  output irq;
  output [15:0] readdata;
  input  [2:0] address;
  input  chipselect;
  input  clk;
  input  reset_n;
  input  write_n;
  input  [15:0] writedata;
  wire clk_en;
  wire control_continuous;
  wire control_interrupt_enable;
  reg  [3:0] control_register;
  wire control_wr_strobe;
  reg  counter_is_running;
  wire counter_is_zero;
  wire [31:0] counter_load_value;
  reg  [31:0] counter_snapshot;
  reg  delayed_unxcounter_is_zeroxx0;
  wire do_start_counter;
  wire do_stop_counter;
  reg  force_reload;
  reg  [31:0] internal_counter;
  wire irq;
  reg  [15:0] period_h_register;
  wire period_h_wr_strobe;
  reg  [15:0] period_l_register;
  wire period_l_wr_strobe;
  wire [15:0] read_mux_out;
  reg  [15:0] readdata;
  wire snap_h_wr_strobe;
  wire snap_l_wr_strobe;
  wire [31:0] snap_read_value;
  wire snap_strobe;
  wire start_strobe;
  wire status_wr_strobe;
  wire stop_strobe;
  wire timeout_event;
  reg  timeout_occurred;


endmodule

