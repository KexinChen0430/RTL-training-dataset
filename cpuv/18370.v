module implementation
always @ (posedge clock or posedge reset)
begin
	if (reset)
		count16 <= 4'b0;
	else if (tx_busy & ce_16)
		count16 <= count16 + 4'b1;
	else if (~tx_busy)
		count16 <= 4'b0;
end
assign ce_1 = (count16 == 4'b1111) & ce_16;
always @ (posedge clock or posedge reset)
begin
	if (reset)
		tx_busy <= 1'b0;
	else if (~tx_busy & new_tx_data)
		tx_busy <= 1'b1;
	else if (tx_busy & (bit_count == 4'h9) & ce_1)
		tx_busy <= 1'b0;
end
always @ (posedge clock or posedge reset)
begin
	if (reset)
		bit_count <= 4'h0;
	else if (tx_busy & ce_1)
		bit_count <= bit_count + 4'h1;
	else if (~tx_busy)
		bit_count <= 4'h0;
end
always @ (posedge clock or posedge reset)
begin
	if (reset)
		data_buf <= 9'b0;
	else if (~tx_busy)
		data_buf <= {tx_data, 1'b0};
	else if (tx_busy & ce_1)
		data_buf <= {1'b1, data_buf[8:1]};
end
always @ (posedge clock or posedge reset)
begin
	if (reset)
		ser_out <= 1'b1;
	else if (tx_busy)
		ser_out <= data_buf[0];
	else
		ser_out <= 1'b1;
end
endmodule