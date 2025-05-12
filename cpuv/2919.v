module kernel_clock_0_out_arbitrator (
  input            clk, 
  input            d1_vga_0_avalon_slave_0_end_xfer, 
  input   [ 19: 0] kernel_clock_0_out_address, 
  input   [  1: 0] kernel_clock_0_out_byteenable, 
  input            kernel_clock_0_out_granted_vga_0_avalon_slave_0, 
  input            kernel_clock_0_out_qualified_request_vga_0_avalon_slave_0, 
  input            kernel_clock_0_out_read, 
  input            kernel_clock_0_out_read_data_valid_vga_0_avalon_slave_0, 
  input            kernel_clock_0_out_requests_vga_0_avalon_slave_0, 
  input            kernel_clock_0_out_write, 
  input   [ 15: 0] kernel_clock_0_out_writedata, 
  input            reset_n, 
  input   [ 15: 0] vga_0_avalon_slave_0_readdata_from_sa, 
  input            vga_0_avalon_slave_0_wait_counter_eq_0, 
  output  [ 19: 0] kernel_clock_0_out_address_to_slave, 
  output  [ 15: 0] kernel_clock_0_out_readdata, 
  output           kernel_clock_0_out_reset_n, 
  output           kernel_clock_0_out_waitrequest 
);
reg              active_and_waiting_last_time; 
reg     [ 19: 0] kernel_clock_0_out_address_last_time; 
reg     [  1: 0] kernel_clock_0_out_byteenable_last_time; 
reg              kernel_clock_0_out_read_last_time; 
reg              kernel_clock_0_out_write_last_time; 
reg     [ 15: 0] kernel_clock_0_out_writedata_last_time; 
wire    [ 19: 0] kernel_clock_0_out_address_to_slave;
wire    [ 15: 0] kernel_clock_0_out_readdata;
wire             kernel_clock_0_out_reset_n;
wire             kernel_clock_0_out_run; 
wire             kernel_clock_0_out_waitrequest;
wire             r_2; 
assign r_2 = 1 & ((~kernel_clock_0_out_qualified_request_vga_0_avalon_slave_0 | ~kernel_clock_0_out_read | (1 & ~d1_vga_0_avalon_slave_0_end_xfer & kernel_clock_0_out_read))) & ((~kernel_clock_0_out_qualified_request_vga_0_avalon_slave_0 | ~kernel_clock_0_out_write | (1 & ((vga_0_avalon_slave_0_wait_counter_eq_0 & ~d1_vga_0_avalon_slave_0_end_xfer)) & kernel_clock_0_out_write)));
assign kernel_clock_0_out_run = r_2;
assign kernel_clock_0_out_address_to_slave = kernel_clock_0_out_address;
assign kernel_clock_0_out_readdata = vga_0_avalon_slave_0_readdata_from_sa;
assign kernel_clock_0_out_waitrequest = ~kernel_clock_0_out_run;
assign kernel_clock_0_out_reset_n = reset_n;
always @(posedge clk or negedge reset_n) begin
  if (reset_n == 0)
    kernel_clock_0_out_address_last_time <= 0;
  else
    kernel_clock_0_out_address_last_time <= kernel_clock_0_out_address;
end
always @(posedge clk or negedge reset_n) begin
  if (reset_n == 0)
    active_and_waiting_last_time <= 0;
  else
    active_and_waiting_last_time <= kernel_clock_0_out_waitrequest & (kernel_clock_0_out_read | kernel_clock_0_out_write);
end
always @(posedge clk) begin
  if (active_and_waiting_last_time & (kernel_clock_0_out_address != kernel_clock_0_out_address_last_time)) begin
    $write("%0d ns: kernel_clock_0_out_address did not heed wait!!!", $time);
    $stop;
  end
end
endmodule