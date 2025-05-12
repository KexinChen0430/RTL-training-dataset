module implementation
always @ (posedge clock or posedge reset)
begin
	if (reset)
		counter <= 16'b0;
	else if (counter >= baud_limit)
		counter <= counter - baud_limit;
	else
		counter <= counter + baud_freq;
end
always @ (posedge clock or posedge reset)
begin
	if (reset)
		ce_16 <= 1'b0;
	else if (counter >= baud_limit)
		ce_16 <= 1'b1;
	else
		ce_16 <= 1'b0;
end
endmodule