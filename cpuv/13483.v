module tx_port_monitor_64 #(
	parameter C_DATA_WIDTH = 9'd64, 
	parameter C_FIFO_DEPTH = 512, 
	parameter C_FIFO_DEPTH_THRESH = (C_FIFO_DEPTH - 4), 
	parameter C_FIFO_DEPTH_WIDTH = clog2((2**clog2(C_FIFO_DEPTH))+1), 
	parameter C_VALID_HIST = 1 
)
(
	input RST, 
	input CLK, 
	input [C_DATA_WIDTH:0] EVT_DATA, 
	input EVT_DATA_EMPTY, 
	output EVT_DATA_RD_EN, 
	output [C_DATA_WIDTH-1:0] WR_DATA, 
	output WR_EN, 
	input [C_FIFO_DEPTH_WIDTH-1:0] WR_COUNT, 
	output TXN, 
	input ACK, 
	output LAST, 
	output [31:0] LEN, 
	output [30:0] OFF, 
	output [31:0] WORDS_RECVD, 
	output DONE, 
	input TX_ERR 
);
`include "functions.vh"
(* syn_encoding = "user" *)
(* fsm_encoding = "user" *)
reg 	[5:0]				rState=`S_TXPORTMON64_NEXT, _rState=`S_TXPORTMON64_NEXT;
reg 						rRead=0, _rRead=0; 
reg 	[C_VALID_HIST-1:0]	rDataValid={C_VALID_HIST{1'd0}}, _rDataValid={C_VALID_HIST{1'd0}}; 
reg 						rEvent=0, _rEvent=0; 
reg 	[63:0]				rReadData=64'd0, _rReadData=64'd0; 
reg 	[31:0]				rWordsRecvd=0, _rWordsRecvd=0; 
reg 	[31:0]				rWordsRecvdAdv=0, _rWordsRecvdAdv=0; 
reg 						rAlmostAllRecvd=0, _rAlmostAllRecvd=0; 
reg 						rAlmostFull=0, _rAlmostFull=0; 
reg 						rLenEQ0Hi=0, _rLenEQ0Hi=0; 
reg 						rLenEQ0Lo=0, _rLenEQ0Lo=0; 
reg 						rLenLE2Lo=0, _rLenLE2Lo=0; 
reg							rTxErr=0, _rTxErr=0; 
wire wEventData = (rDataValid[0] & EVT_DATA[C_DATA_WIDTH]);
wire wPayloadData = (rDataValid[0] & !EVT_DATA[C_DATA_WIDTH] & rState[3]); 
wire wAllWordsRecvd = ((rAlmostAllRecvd | (rLenEQ0Hi & rLenLE2Lo)) & wPayloadData);
assign EVT_DATA_RD_EN = rRead;
assign WR_DATA = EVT_DATA[C_DATA_WIDTH-1:0];
assign WR_EN = wPayloadData; 
assign TXN = rState[2]; 
assign LAST = rReadData[0];
assign OFF = rReadData[31:1];
assign LEN = rReadData[63:32];
assign WORDS_RECVD = rWordsRecvd;
assign DONE = !rState[3]; 
always @ (posedge CLK) begin
	rTxErr <= #1 (RST ? 1'd0 : _rTxErr);
end
always @ (*) begin
	_rTxErr = TX_ERR;
end
always @ (posedge CLK) begin
	rState <= #1 (RST ? `S_TXPORTMON64_NEXT : _rState);
end
always @ (*) begin
	_rState = rState;
	case (rState)
	`S_TXPORTMON64_NEXT: begin 
		if (rEvent)
			_rState = `S_TXPORTMON64_EVT_2;
	end
	`S_TXPORTMON64_EVT_2: begin 
		if (rEvent)
			_rState = `S_TXPORTMON64_TXN;
	end
	`S_TXPORTMON64_TXN: begin 
		if (ACK)
			_rState = ((rLenEQ0Hi && rLenEQ0Lo) ? `S_TXPORTMON64_END_0 : `S_TXPORTMON64_READ);
	end
	`S_TXPORTMON64_READ: begin 
		if (rEvent)
			_rState = `S_TXPORTMON64_END_1;
		else if (wAllWordsRecvd | rTxErr)
			_rState = `S_TXPORTMON64_END_0;
	end
	`S_TXPORTMON64_END_0: begin 
		if (rEvent)
			_rState = `S_TXPORTMON64_END_1;
	end
	`S_TXPORTMON64_END_1: begin 
		if (rEvent)
			_rState = `S_TXPORTMON64_NEXT;
	end
	default: begin
		_rState = `S_TXPORTMON64_NEXT;
	end
	endcase
end
always @ (posedge CLK) begin
	rRead <= #1 (RST ? 1'd0 : _rRead);
	rDataValid <= #1 (RST ? {C_VALID_HIST{1'd0}} : _rDataValid);
	rEvent <= #1 (RST ? 1'd0 : _rEvent);
	rReadData <= #1 _rReadData;
	rWordsRecvd <= #1 _rWordsRecvd;
	rWordsRecvdAdv <= #1 _rWordsRecvdAdv;
	rAlmostAllRecvd <= #1 _rAlmostAllRecvd;
	rAlmostFull <= #1 _rAlmostFull;
	rLenEQ0Hi <= #1 _rLenEQ0Hi;
	rLenEQ0Lo <= #1 _rLenEQ0Lo;
	rLenLE2Lo <= #1 _rLenLE2Lo;
end
always @ (*) begin
	_rAlmostFull = (WR_COUNT >= C_FIFO_DEPTH_THRESH);
	_rDataValid = ((rDataValid<<1) | (rRead & !EVT_DATA_EMPTY));
	_rRead = (!rState[2] & !(rState[1] & (rEvent | wEventData | ~EVT_DATA_EMPTY)) & !wEventData & !rAlmostFull); 
	_rEvent = wEventData;
	if (wEventData)
		_rReadData = EVT_DATA[C_DATA_WIDTH-1:0];
	else
		_rReadData = rReadData;
	_rLenEQ0Hi = (LEN[31:16] == 16'd0);
	_rLenEQ0Lo = (LEN[15:0] == 16'd0);
	_rLenLE2Lo = (LEN[15:0] <= 16'd2);
	_rWordsRecvd = (ACK ? 0 : rWordsRecvd + (wPayloadData<<1));
	_rWordsRecvdAdv = (ACK ? 2*(C_DATA_WIDTH/32) : rWordsRecvdAdv + (wPayloadData<<1));
	_rAlmostAllRecvd = ((rWordsRecvdAdv >= LEN) && wPayloadData);
end
endmodule