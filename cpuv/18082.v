module meet the requirement(well i don't know the exact number, find it by yourself). 
end
assign avs_readdata = read_data_buf; 
always @ (posedge csi_clk or negedge csi_reset_n)
if (!csi_reset_n) begin
	read_data_buf <= 32'b0;
else if (!avs_read_n) begin
	read_data_buf <= read_reg_buf[avs_address];
else begin
	read_data_buf <= read_data_buf;
`undef		SEC_DATA_LEN
`undef		NS_DATA_LEN
`undef		CTRL_CNT_LEN
`undef		ERR_CNT_LEN
`undef		UTC_TIME_LEN
`undef		TIME_ZONE_LEN
`undef		LEAP_CNT_LEN
`undef		LEAP_OCCR_LEN
`undef		LEAP_DCT_LEN
`undef		DST_INEN_LEN
`undef		TIME_QLT_LEN
endmodule