module dsu_Tx(clk, rst, TxD_start, TxD_data, TxD, TxD_busy);
input clk, rst, TxD_start; 
input [7:0] TxD_data; 
output TxD, TxD_busy; 
parameter Baud = 115200; 
parameter RegisterInputData = 1; 
parameter BaudGeneratorAccWidth = 16; 
reg [BaudGeneratorAccWidth:0] BaudGeneratorAcc; 
`ifdef FPGA_50MHZ
wire [BaudGeneratorAccWidth:0] BaudGeneratorInc = 17'h00097; 
`endif
`ifdef FPGA_32MHZ
wire [BaudGeneratorAccWidth:0] BaudGeneratorInc = 17'h000ec; 
`endif
`ifdef FPGA_64MHZ
wire [BaudGeneratorAccWidth:0] BaudGeneratorInc = 17'h00076; 
`endif
wire BaudTick = BaudGeneratorAcc[BaudGeneratorAccWidth]; 
wire TxD_busy; 
always@(posedge clk or `dsu_RST_EVENT rst)
   begin
    if(rst==`dsu_RST_VALUE)
    	 BaudGeneratorAcc <= 16'h0000; 
    else if(TxD_busy)
       BaudGeneratorAcc <= BaudGeneratorAcc[BaudGeneratorAccWidth-1:0] + BaudGeneratorInc; 
   end
reg [3:0] state; 
wire TxD_ready = (state==0); 
assign TxD_busy = ~TxD_ready; 
reg [7:0] TxD_dataReg; 
always@(posedge clk or `dsu_RST_EVENT rst)
   begin
    if(rst==`dsu_RST_VALUE)
    TxD_dataReg <= 8'h00; 
  else if(TxD_ready & TxD_start)
    TxD_dataReg <= TxD_data; 
  end
wire [7:0] TxD_dataD = RegisterInputData ? TxD_dataReg : TxD_data; 
always@(posedge clk or `dsu_RST_EVENT rst)
   begin
    if(rst==`dsu_RST_VALUE)
       state <= 4'h0; 
    else
			case(state) 
				4'b0000: if(TxD_start) state <= 4'b0001; 
				4'b0001: if(BaudTick) state <= 4'b0100; 
				4'b1111: if(BaudTick) state <= 4'b0010; 
				4'b0010: if(BaudTick) state <= 4'b0011; 
				4'b0011: if(BaudTick) state <= 4'b0000; 
				default: if(BaudTick) state <= 4'b0000; 
			endcase
	end
reg muxbit; 
always @ ( * )
 begin
			case(state[2:0]) 
			endcase
 end
reg TxD; 
always@(posedge clk or `dsu_RST_EVENT rst)
   begin
    if(rst==`dsu_RST_VALUE)
         TxD <= 1'b1; 
      else
 				 TxD <= (state<4) | (state[3] & muxbit); 
 	end
endmodule