module recon_1_top #(parameter PORT_0_WIDTH = 32) (
  input sys_clk,
  input sys_rstn,
  inout [       PORT_0_WIDTH-1:0] port_0_io,
  output                          uart_0_txd,
  input                           uart_0_rxd,
  output wire                     epcs_0_dclk,                          
	output wire                     epcs_0_sce,                           
	output wire                     epcs_0_sdo,                           
	input  wire                     epcs_0_data0
  );
  wire [PORT_0_WIDTH-1:0] port_0_out;
  wire [PORT_0_WIDTH-1:0] port_0_in;
  wire [PORT_0_WIDTH-1:0] port_0_oe;
  wire [PORT_0_WIDTH-1:0] port_0_opdrn;
  buttonDebouncer
  #(  
    .pDEBOUNCE_PERIOD     (100_000_000),
    .pCLKIN_PERIOD        (20         ),
    .pARRAY_SIZE          (1          ),
    .pPOLARITY            (0)) resetDebounce
  (
    .clk                  (sys_clk),
    .buttons              (sys_rstn),
    .buttonState          (sys_rstn_db),  
    .buttonUpTick         (),
    .buttonDwTick         ()
  );
    recon_1 (
    .altpll_0_locked_export               (       ),               
    .clk_clk                              (sys_clk),               
    .recon_io_0_io_port_io_out            (port_0_out),            
    .recon_io_0_io_port_io_opdrn          (port_0_opdrn),          
    .recon_io_0_io_port_io_in             (port_0_in),             
    .recon_io_0_io_port_io_oe             (port_0_oe),             
    .recon_timer_0_clock_tick_second      (),                      
    .recon_timer_0_clock_tick_millisecond (),                      
    .recon_timer_0_clock_tick_microsec    (),                      
    .reset_reset_n                        (sys_rstn_db),           
    .uart_0_rxd                           (uart_0_rxd),
    .uart_0_txd                           (uart_0_txd),
    .epcs_0_dclk                          (epcs_0_dclk),            
		.epcs_0_sce                           (epcs_0_sce),             
		.epcs_0_sdo                           (epcs_0_sdo),             
		.epcs_0_data0                         (epcs_0_data0)
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