module 
always@(posedge clk_proc or negedge reset_n)
	if (reset_n == 0)
		data_d <= 0;
	else
		begin
			dir_d <= d_max; 
			if (token_s[7])
				if (m_max[((COEF_WIDTH + IN_SIZE)+1):0] > threshold[((COEF_WIDTH + IN_SIZE)+1):0])
					if(binarize_bit)
						data_d <= {(COEF_WIDTH + IN_SIZE - NORM_FACTOR){1'b1}};
					else
						data_d <= m_max[(COEF_WIDTH + IN_SIZE):NORM_FACTOR-1];
				else
					if(binarize_bit)
						data_d <= {(COEF_WIDTH + IN_SIZE - NORM_FACTOR){1'b0}};
					else
						data_d <= {(COEF_WIDTH + IN_SIZE - NORM_FACTOR){1'b0}};
		end
assign magnitude_data = data_d; 
assign angle_data  	  = dir_d; 
assign magnitude_dv   = token_s[8]; 
assign angle_dv		  = token_s[8]; 
assign magnitude_fv = (token_d[8]) ? 1'b1 : 1'b0; 
assign angle_fv = (token_d[8]) ? 1'b1 : 1'b0; 
always @ (*)
	if (wr_i) 
		case(addr_rel_i) 
			1'd0:
				begin
					config_setup_new = datawr_i; 
					threshold_new = threshold; 
				end
			1'd1:
				begin
					config_setup_new = config_setup; 
					threshold_new = datawr_i; 
				end
			default:
				begin
					config_setup_new = config_setup;
					threshold_new = threshold;
				end
		endcase
	else	
		begin
			config_setup_new = config_setup;
			threshold_new = threshold;
		end
always @ (*)
	if (rd_i) 
		case(addr_rel_i) 
			1'd0:	readdata_new = config_setup; 
			1'd1:	readdata_new = threshold; 
			default:
				readdata_new = datard_o; 
		endcase
	else
		readdata_new = datard_o; 
always @ (posedge clk_proc or negedge reset_n)
	if (reset_n == 1'b0)
		begin
			config_setup	<= DEFAULT_SCR;
			threshold		<= DEFAULT_TH;
			datard_o		<= 32'b0;
		end
	else
		begin
			config_setup	<= config_setup_new;
			threshold		<= threshold_new;
			datard_o		<= readdata_new;
		end
endmodule 