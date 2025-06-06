module my_uart_tx7to7(
	clk,            
	rst_n,          
	uart_ctl,       
	data_out,       
	data_sign,      
	data_valid,     
	rs_tx           
);
input	clk;
input	rst_n;
input	[2:0]	uart_ctl;
input	[6:0]	data_out;
input	data_sign;
output	data_valid;
output	rs_tx;
parameter 	bps9600 	= 13'd5208,	
		 	bps19200 	= 13'd2603,	
			bps38400 	= 13'd1301,	
			bps57600 	= 13'd867,	
			bps115200	= 13'd434,	
			bps256000	= 13'd195;	
reg		[12:0]		cnt;        
reg					bps_sel;    
reg		[3:0]		tran_cnt;   
reg					rs_tx;      
reg					sign_delay; 
reg					data_valid; 
always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		bps_sel <= 1'b0;          
		cnt <= 'h0;               
	end
	else begin
		case(uart_ctl)
			3'h0:  cnt <= (cnt == bps9600) ? 'h0 : cnt + 1'b1;
			3'h1:  cnt <= (cnt == bps19200) ? 'h0 : cnt + 1'b1;
			3'h2:  cnt <= (cnt == bps38400) ? 'h0 : cnt + 1'b1;
			3'h3:  cnt <= (cnt == bps57600) ? 'h0 : cnt + 1'b1;
			3'h4:  cnt <= (cnt == bps115200) ? 'h0 : cnt + 1'b1;
			3'h5:  cnt <= (cnt == bps256000) ? 'h0 : cnt + 1'b1;
			default: cnt <= (cnt == bps9600) ? 'h0 : cnt + 1'b1;
		endcase
		bps_sel <= ~|cnt;         
	end
end
always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		sign_delay <= 1'b0;       
		data_valid <= 1'b0;       
	end
	else begin
		if(bps_sel)	sign_delay <= 1'b0; 
		else if(data_sign)	sign_delay <= 1'b1; 
		if(data_sign | sign_delay)	data_valid <= 1'b0; 
		else if(tran_cnt== 8)		data_valid <= 1'b1; 
	end
end
always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		tran_cnt <= 'h8;          
	end
	else if (bps_sel)begin
		if(tran_cnt != 8)	tran_cnt <= tran_cnt + 1'b1; 
		else if (data_sign|sign_delay)	tran_cnt <= 'h0; 
	end
end
always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		rs_tx <= 1'b1;            
	end
	else if (bps_sel) begin
		if(tran_cnt == 0)		rs_tx <= 1'b0 ; 
		else if(tran_cnt == 8)	rs_tx <= 1'b1; 
		else					rs_tx <= data_out[tran_cnt - 1]; 
	end
end
endmodule 