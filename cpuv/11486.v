module recon_0a_top #(parameter PORT_0_WIDTH = 16) ( 
  input sys_clk, 
  input sys_rstn, 
  inout [PORT_0_WIDTH-1:0] port_0_io, 
  output uart_0_txd, 
  input uart_0_rxd 
  );
  wire [PORT_0_WIDTH-1:0] port_0_out; 
  wire [PORT_0_WIDTH-1:0] port_0_in; 
  wire [PORT_0_WIDTH-1:0] port_0_oe; 
  wire [PORT_0_WIDTH-1:0] port_0_opdrn; 
  wire cpu_clk, locked; 
  alt_pll pll( 
	.areset   (~sys_rstn), 
	.inclk0   (sys_clk), 
	.c0       (cpu_clk), 
	.locked   (locked)); 
  buttonDebouncer 
  #(  
    .pDEBOUNCE_PERIOD     (100_000_000), 
    .pCLKIN_PERIOD        (20), 
    .pARRAY_SIZE          (1), 
    .pPOLARITY            (0)) resetDebounce 
  (
    .clk                  (sys_clk), 
    .buttons              (sys_rstn), 
    .buttonState          (sys_rstn_db), 
    .buttonUpTick         (), 
    .buttonDwTick         () 
  );
  recon_0a ( 
    .adc_0_adc_pll_input_export           (locked), 
    .clk_clk                              (cpu_clk), 
    .recon_io_0_io_port_io_out            (port_0_out), 
    .recon_io_0_io_port_io_opdrn          (port_0_opdrn), 
    .recon_io_0_io_port_io_in             (port_0_in), 
    .recon_io_0_io_port_io_oe             (port_0_oe), 
    .recon_timer_0_clock_tick_second      (), 
    .recon_timer_0_clock_tick_millisecond (), 
    .recon_timer_0_clock_tick_microsec    (), 
    .reset_reset_n                        (sys_rstn_db), 
    .uart_0_rxd                           (uart_0_rxd), 
    .uart_0_txd                           (uart_0_txd) 
  );
  genvar IO; 
  generate 
  for (IO = 0; IO<PORT_0_WIDTH;IO=IO+1) 
  begin : assign_io
    assign port_0_io[IO] = (port_0_oe[IO]==1'b0||(port_0_out[IO]==1'b1&&port_0_opdrn[IO]==1'b1))?1'bz:port_0_out[IO]; 
    assign port_0_in[IO] = port_0_io[IO]; 
  end
  endgenerate 
endmodule 