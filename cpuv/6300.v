module WR_ALIGNER ( PACKET, DP_Q, SIZE, WRDATA, ENBYTE ); 
input	 [3:0]	PACKET;	
input	[63:0]	DP_Q;   
input	 [1:0]	SIZE;   
output	[31:0]	WRDATA; 
output	 [3:0]	ENBYTE; 
reg		 [3:0]	ENBYTE; 
reg		 [7:0]	dbyte0,dbyte1,dbyte2,dbyte3; 
wire			switch; 
assign switch = (SIZE == 2'b11) & (PACKET[3:2] == 2'b00); 
always @(DP_Q or switch or PACKET)
		case (PACKET[1:0])
		  2'b00 : dbyte0 =    switch ?   DP_Q[7:0] : DP_Q[39:32];
		  2'b01 : dbyte0 = PACKET[3] ? DP_Q[63:56] : DP_Q[31:24];
		  2'b10 : dbyte0 = PACKET[3] ? DP_Q[55:48] : DP_Q[23:16];
		  2'b11 : dbyte0 = PACKET[3] ? DP_Q[47:40] :  DP_Q[15:8];
		endcase
assign WRDATA = {dbyte3,dbyte2,dbyte1,dbyte0}; 
always @(SIZE or PACKET)
		casex ({SIZE,PACKET})
		  6'b00_xx_00 : ENBYTE = 4'b0001;	
		endcase
endmodule