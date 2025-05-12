module tb_dsu_rx(clk, rst, RxD, RxD_data_ready, RxD_data, RxD_endofpacket, RxD_idle); 
input clk, rst, RxD; 
output RxD_data_ready;  
output [7:0] RxD_data;  
parameter Baud = 115200; 
output RxD_endofpacket;  
output RxD_idle;  
reg [3:0] state; 
reg [3:0] bit_spacing; 
reg [7:0] RxD_data; 
reg RxD_data_ready, RxD_data_error; 
reg [4:0] gap_count; 
reg RxD_endofpacket; 
parameter Baud8 = Baud*8; 
parameter Baud8GeneratorAccWidth = 16; 
`ifdef FPGA_50MHZ
wire [Baud8GeneratorAccWidth:0] Baud8GeneratorInc = 17'h004b8; 
`endif
`ifdef FPGA_32MHZ
wire [Baud8GeneratorAccWidth:0] Baud8GeneratorInc = 17'h0075f;  
`endif
`ifdef FPGA_64MHZ
wire [Baud8GeneratorAccWidth:0] Baud8GeneratorInc = 17'h003b0;	
`endif
reg [Baud8GeneratorAccWidth:0] Baud8GeneratorAcc; 
always@(posedge clk or `dsu_RST_EVENT rst) 
   begin
    if(rst==`dsu_RST_VALUE) 
   	 Baud8GeneratorAcc <= 32'h0;
   else 
     Baud8GeneratorAcc <= Baud8GeneratorAcc[Baud8GeneratorAccWidth-1:0] + Baud8GeneratorInc;
  end
wire Baud8Tick = Baud8GeneratorAcc[Baud8GeneratorAccWidth]; 
reg [1:0] RxD_sync_inv; 
always@(posedge clk or `dsu_RST_EVENT rst) 
   begin
    if(rst==`dsu_RST_VALUE) 
      RxD_sync_inv <= 2'b00;
   else if(Baud8Tick) 
      RxD_sync_inv <= {RxD_sync_inv[0], ~RxD};
  end
reg [1:0] RxD_cnt_inv; 
reg RxD_bit_inv; 
always@(posedge clk or `dsu_RST_EVENT rst) 
    if(rst==`dsu_RST_VALUE) 
    begin
    	RxD_cnt_inv <= 2'b00;
    	RxD_bit_inv <= 1'b0;
    end
	else if(Baud8Tick) 
		begin
			if( RxD_sync_inv[1] && RxD_cnt_inv!=2'b11)
					RxD_cnt_inv <= RxD_cnt_inv + 2'h1;
			else if(~RxD_sync_inv[1] && RxD_cnt_inv!=2'b00)
				RxD_cnt_inv <= RxD_cnt_inv - 2'h1;
			if(RxD_cnt_inv==2'b00)
				RxD_bit_inv <= 1'b0;
			else if(RxD_cnt_inv==2'b11)
				RxD_bit_inv <= 1'b1;
end
wire next_bit = (bit_spacing==4'd10); 
always@(posedge clk or `dsu_RST_EVENT rst) 
    if(rst==`dsu_RST_VALUE) 
      bit_spacing <= 4'b0000;
	 else if(state==0) 
			bit_spacing <= 4'b0000;
   else if(Baud8Tick) 
			bit_spacing <= {bit_spacing[2:0] + 4'b0001} | {bit_spacing[3], 3'b000};
always@(posedge clk or `dsu_RST_EVENT rst) 
    if(rst==`dsu_RST_VALUE) 
   		state <= 4'b0000;
   else if(Baud8Tick) 
			case(state)
				4'b0000: if(RxD_bit_inv) state <= 4'b1000;  
				4'b1000: if(next_bit) state <= 4'b1001;  
				4'b1001: if(next_bit) state <= 4'b1010;  
				4'b1010: if(next_bit) state <= 4'b1011;  
				4'b1011: if(next_bit) state <= 4'b1100;  
				4'b1100: if(next_bit) state <= 4'b1101;  
				4'b1101: if(next_bit) state <= 4'b1110;  
				4'b1110: if(next_bit) state <= 4'b1111;  
				4'b1111: if(next_bit) state <= 4'b0001;  
				4'b0001: if(next_bit) state <= 4'b0000;  
				default: state <= 4'b0000;
		endcase
always@(posedge clk or `dsu_RST_EVENT rst) 
    if(rst==`dsu_RST_VALUE) 
  	RxD_data <= 8'h00;
	else if(Baud8Tick && next_bit && state[3]) 
		RxD_data <= {~RxD_bit_inv, RxD_data[7:1]};
always@(posedge clk or `dsu_RST_EVENT rst) 
   begin
    if(rst==`dsu_RST_VALUE) 
		  begin
		  	RxD_data_ready <= 1'b0;
		  	RxD_data_error <= 1'b0;
		  end
		else 
			begin
				RxD_data_ready <= (Baud8Tick && next_bit && state==4'b0001 && ~RxD_bit_inv);  
				RxD_data_error <= (Baud8Tick && next_bit && state==4'b0001 &&  RxD_bit_inv);  
			end
	end
always@(posedge clk or `dsu_RST_EVENT rst) 
   begin
    if(rst==`dsu_RST_VALUE) 
  		gap_count <=  5'h10;
  	else if (state!=0) 
  	 	gap_count<=5'h00;
  	else if(Baud8Tick & ~gap_count[4]) 
  		gap_count <= gap_count + 5'h01;
  end
assign RxD_idle = gap_count[4]; 
always@(posedge clk or `dsu_RST_EVENT rst) 
    if(rst==`dsu_RST_VALUE) 
  	RxD_endofpacket <= 1'b0;
  else 
    RxD_endofpacket <= Baud8Tick & (gap_count==5'h0F);
endmodule