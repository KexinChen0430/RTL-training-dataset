module. 
initial	o_valid = 1'b0; 
always @(posedge i_clk) 
	if (i_rst) 
		o_valid <= 1'b0; 
	else if (r_busy) 
		begin
			if ((last_bit)||(zero_divisor)) 
				o_valid <= (zero_divisor)||(!r_sign); 
		end else if (r_sign) 
		begin
			o_valid <= (!zero_divisor); 
		end else
			o_valid <= 1'b0; 
initial	o_err = 1'b0; 
always @(posedge i_clk) 
	if((i_rst)||(o_valid)) 
		o_err <= 1'b0; 
	else if (((r_busy)||(r_sign))&&(zero_divisor)) 
		o_err <= 1'b1; 
	else
		o_err <= 1'b0; 
always @(posedge i_clk) 
	if ((r_busy)&&(!pre_sign)) 
		r_bit <= r_bit + {(LGBW){1'b1}}; 
	else
		r_bit <= {(LGBW){1'b1}}; 
initial	last_bit = 1'b0; 
always @(posedge i_clk) 
	if (r_busy) 
		last_bit <= (r_bit == {{(LGBW-1){1'b0}},1'b1}); 
	else
		last_bit <= 1'b0; 
initial	pre_sign = 1'b0; 
always @(posedge i_clk) 
	if (i_wr) 
		pre_sign <= i_signed; 
	else
		pre_sign <= 1'b0; 
always @(posedge i_clk) 
	if((r_busy)&&(r_divisor[(2*BW-2):(BW)] == 0)&&(!diff[BW])) 
		r_z <= 1'b0; 
	else if ((!r_busy)&&(!r_sign)) 
		r_z <= 1'b1; 
always @(posedge i_clk) 
	if (pre_sign) 
		begin
			if (r_dividend[BW-1]) 
				r_dividend <= -r_dividend; 
		end else if((r_busy)&&(r_divisor[(2*BW-2):(BW)]==0)&&(!diff[BW])) 
		r_dividend <= diff[(BW-1):0]; 
	else if (!r_busy) 
		r_dividend <=  i_numerator; 
initial	r_divisor = 0; 
always @(posedge i_clk) 
	if (pre_sign) 
		begin
			if (r_divisor[(2*BW-2)]) 
				r_divisor[(2*BW-2):(BW-1)] <= -r_divisor[(2*BW-2):(BW-1)]; 
		end else if (r_busy) 
			r_divisor <= { 1'b0, r_divisor[(2*BW-2):1] }; 
	else
		r_divisor <= {  i_denominator, {(BW-1){1'b0}} }; 
initial	r_sign = 1'b0; 
always @(posedge i_clk) 
	if (pre_sign) 
		r_sign <= ((r_divisor[(2*BW-2)])^(r_dividend[(BW-1)])); 
	else if (r_busy) 
		r_sign <= (r_sign)&&(!zero_divisor); 
	else
		r_sign <= 1'b0; 
always @(posedge i_clk) 
	if (r_busy) 
		begin
			o_quotient <= { o_quotient[(BW-2):0], 1'b0 }; 
			if ((r_divisor[(2*BW-2):(BW)] == 0)&&(!diff[BW])) 
			begin
				o_quotient[0] <= 1'b1; 
			end
		end else if (r_sign) 
			o_quotient <= -o_quotient; 
	else
		o_quotient <= 0; 
always @(posedge i_clk) 
	r_c <= (r_busy)&&((diff == 0)||(r_dividend == 0)); 
wire	w_n;
assign w_n = o_quotient[(BW-1)]; 
assign o_flags = { 1'b0, w_n, r_c, r_z }; 
endmodule 