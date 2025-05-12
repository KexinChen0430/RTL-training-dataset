always@(posedge clk or negedge resetn)
  if (!resetn)
    reset_count <= 10'b0;
  else if (pio_out_sw_reset)
    reset_count <= 10'b0;
  else if (!reset_count[9])
    reset_count <= reset_count + 2'b01;
always@(posedge clk)
begin
  pio_out_ddr_mode = pio_out[9:8];
  pio_out_pll_reset = pio_out[30];
  pio_out_sw_reset = pio_out[31];
end
always@(posedge clk)
begin
  pio_in = {
            lock_kernel_pll,
            fixedclk_locked,
            1'b0,
            1'b0,
            mem1_local_cal_fail,
            mem0_local_cal_fail,
            mem1_local_cal_success,
            mem1_local_init_done,
            mem0_local_cal_success,
            mem0_local_init_done};
end
always@(posedge clk)
  mem_organization = pio_out_ddr_mode;
assign mem_organization_export = mem_organization;
assign pll_reset = pio_out_pll_reset;
always@(posedge clk)
  sw_reset_n_out = !(!reset_count[9] && (reset_count[8:0] != 0));