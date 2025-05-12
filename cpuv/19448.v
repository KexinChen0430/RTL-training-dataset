module. 
reg ssp_frame; 
always @(negedge adc_clk) 
begin
	if (mod_type == `FPGA_HF_SIMULATOR_MODULATE_212K) 
	begin
		if (ssp_clk_divider[8:5] == 4'd1) 
			ssp_frame <= 1'b1; 
		if (ssp_clk_divider[8:5] == 4'd5) 
			ssp_frame <= 1'b0; 
	end
	else 
	begin
		if (ssp_clk_divider[7:4] == 4'd1) 
			ssp_frame <= 1'b1; 
		if (ssp_clk_divider[7:4] == 4'd5) 
			ssp_frame <= 1'b0; 
	end
end
reg ssp_din; 
always @(posedge ssp_clk) 
    ssp_din = after_hysteresis; 
reg modulating_carrier; 
always @(*) 
    if (mod_type == `FPGA_HF_SIMULATOR_NO_MODULATION) 
        modulating_carrier <= 1'b0; 
    else if (mod_type == `FPGA_HF_SIMULATOR_MODULATE_BPSK) 
        modulating_carrier <= ssp_dout ^ ssp_clk_divider[3]; 
    else if (mod_type == `FPGA_HF_SIMULATOR_MODULATE_212K) 
        modulating_carrier <= ssp_dout & ssp_clk_divider[5]; 
    else if (mod_type == `FPGA_HF_SIMULATOR_MODULATE_424K || mod_type == `FPGA_HF_SIMULATOR_MODULATE_424K_8BIT) 
        modulating_carrier <= ssp_dout & ssp_clk_divider[4]; 
    else 
        modulating_carrier <= 1'b0; 
assign pwr_hi = 1'b0; 
assign pwr_oe3 = 1'b0; 
assign pwr_oe1 = 1'b0; 
assign pwr_oe4 = modulating_carrier; 
assign pwr_lo = 1'b0; 
assign pwr_oe2 = 1'b0; 
assign dbg = ssp_frame; 
endmodule 