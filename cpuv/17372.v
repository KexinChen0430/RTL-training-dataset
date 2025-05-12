module implementation
always @ (posedge clock or posedge reset)
begin
	if (reset)
		in_sync <= 2'b11; 
	else
		in_sync <= {in_sync[0], ser_in}; 
end
always @ (posedge clock or posedge reset)
begin
	if (reset)
		count16 <= 4'b0; 
	else if (ce_16)
	begin
		if (rx_busy | (in_sync[1] == 1'b0))
			count16 <= count16 + 4'b1; 
		else
			count16 <= 4'b0; 
	end
end
assign ce_1 = (count16 == 4'b1111) & ce_16; 
assign ce_1_mid = (count16 == 4'b0111) & ce_16; 
always @ (posedge clock or posedge reset)
begin
	if (reset)
		rx_busy <= 1'b0; 
	else if (~rx_busy & ce_1_mid)
		rx_busy <= 1'b1; 
	else if (rx_busy & (bit_count == 4'h8) & ce_1_mid)
		rx_busy <= 1'b0; 
end
always @ (posedge clock or posedge reset)
begin
	if (reset)
		bit_count <= 4'h0; 
	else if (~rx_busy)
		bit_count <= 4'h0; 
	else if (rx_busy & ce_1_mid)
		bit_count <= bit_count + 4'h1; 
end
always @ (posedge clock or posedge reset)
begin
	if (reset)
		data_buf <= 8'h0; 
	else if (rx_busy & ce_1_mid)
		data_buf <= {in_sync[1], data_buf[7:1]}; 
end
always @ (posedge clock or posedge reset)
begin
	if (reset)
	begin
		rx_data <= 8'h0; 
		new_rx_data <= 1'b0; 
	end
	else if (rx_busy & (bit_count == 4'h8) & ce_1)
	begin
		rx_data <= data_buf; 
		new_rx_data <= 1'b1; 
	end
	else
		new_rx_data <= 1'b0; 
end
endmodule