module tx_arbiter 
#(
  parameter C_TXC_PRIORITY = 1, 
  parameter C_TXR_PRIORITY = 1) 
(
 input  CLK, 
 input  RST_IN, 
 input  TX_TLP_READY, 
 output TXR_TLP_READY, 
 input  TXR_TLP_VALID, 
 input  TXR_TLP_START_FLAG, 
 input  TXR_TLP_END_FLAG, 
 output TXC_TLP_READY, 
 input  TXC_TLP_VALID, 
 input  TXC_TLP_START_FLAG, 
 input  TXC_TLP_END_FLAG 
 );
localparam S_TXARB_IDLE = 0; 
localparam S_TXARB_TRANSMIT_TXR = 1; 
localparam S_TXARB_TRANSMIT_TXC = 2; 
localparam S_TXARB_PRIORITY = (S_TXARB_TRANSMIT_TXR >= S_TXARB_TRANSMIT_TXC)? S_TXARB_TRANSMIT_TXR: S_TXARB_TRANSMIT_TXC;
localparam C_NUM_STATES = S_TXARB_TRANSMIT_TXC; 
wire    wTxrGrant;
wire    wTxrReq;
wire    wTxrDone;
wire    wTxcGrant;
wire    wTxcReq;
wire    wTxcDone;
reg [clog2s(C_NUM_STATES):0] rArbState,_rArbState; 
reg                          rTxrLast,_rTxrLast; 
reg                          rTxcLast,_rTxcLast; 
reg                          rTxrActive,_rTxrActive; 
reg                          rTxcActive,_rTxcActive; 
reg [clog2s(C_TXC_PRIORITY)-1:0] rTxcCounter,_rTxcCounter; 
reg [clog2s(C_TXR_PRIORITY)-1:0] rTxrCounter,_rTxrCounter; 
assign TXR_TLP_READY = wTxrGrant & TX_TLP_READY; 
assign wTxrReq = TXR_TLP_START_FLAG & TXR_TLP_VALID; 
assign wTxrDone = TXR_TLP_END_FLAG & TXR_TLP_READY; 
assign wTxrGrant = (rArbState == S_TXARB_TRANSMIT_TXR); 
assign TXC_TLP_READY = wTxcGrant & TX_TLP_READY; 
assign wTxcReq = TXC_TLP_START_FLAG & TXC_TLP_VALID; 
assign wTxcDone = TXC_TLP_END_FLAG & TXC_TLP_READY; 
assign wTxcGrant = (rArbState == S_TXARB_TRANSMIT_TXC); 
always @(*) begin
    _rTxcCounter  = rTxcCounter;
    _rTxcActive   = rTxcActive;
    _rTxcLast     = rTxcLast;
    if(wTxrGrant) begin
        _rTxcCounter = 0;
    end else if(wTxcReq & wTxcGrant & ~rTxcLast) begin
        _rTxcCounter = _rTxcCounter + 1;
    end
    if(wTxcReq & wTxcGrant) begin
        _rTxcActive = 1;
    end else if(wTxcDone) begin
        _rTxcActive = 0;
    end
    if(wTxrGrant | RST_IN) begin
        _rTxcLast = 0;
    end else if(wTxcReq & wTxcGrant) begin
        _rTxcLast = (rTxcCounter == (C_TXC_PRIORITY - 1));
    end
end 
always @(posedge CLK) begin
    if(RST_IN) begin
        rTxcCounter <= #1 0;
        rTxcActive  <= #1 0;
        rTxcLast    <= #1 0;
    end else begin
        rTxcCounter <= #1  _rTxcCounter;
        rTxcActive  <= #1  _rTxcActive;
        rTxcLast    <= #1  _rTxcLast;
    end
end
always @(*) begin
    _rTxrCounter  = rTxrCounter;
    _rTxrActive   = rTxrActive;
    _rTxrLast     = rTxrLast;
    if(wTxcGrant) begin
        _rTxrCounter = 0;
    end else if(wTxrReq & wTxrGrant & ~rTxrLast) begin
        _rTxrCounter = _rTxrCounter + 1;
    end
    if(wTxrReq & wTxrGrant) begin
        _rTxrActive = 1;
    end else if(wTxrDone) begin
        _rTxrActive = 0;
    end
    if(wTxcGrant | RST_IN) begin
        _rTxrLast = 0;
    end else if(wTxrReq & wTxrGrant) begin
        _rTxrLast  = (rTxrCounter == (C_TXR_PRIORITY - 1));
    end
end
always @(posedge CLK) begin
    if(RST_IN) begin
        rTxrCounter <= #1 0;
        rTxrActive  <= #1 0;
        rTxrLast    <= #1 0;
    end else begin
        rTxrCounter <= #1 _rTxrCounter;
        rTxrActive  <= #1 _rTxrActive;
        rTxrLast    <= #1 _rTxrLast;
    end
end
always @(*) begin
    _rArbState = rArbState;
    case(rArbState)
        S_TXARB_TRANSMIT_TXR: begin
            if((rTxrLast & wTxrDone & wTxcReq) | (~rTxrActive & ~wTxrReq & wTxcReq)) begin
                _rArbState = S_TXARB_TRANSMIT_TXC;
            end
        end
        S_TXARB_TRANSMIT_TXC: begin
            if((rTxcLast & wTxcDone & wTxrReq) | (~rTxcActive & ~wTxcReq & wTxrReq)) begin
                _rArbState = S_TXARB_TRANSMIT_TXR;
            end
        end
        default: begin
        end
    endcase
end 
always @(posedge CLK) begin
    if(RST_IN) begin
        rArbState <= #1 S_TXARB_PRIORITY;
    end else begin
        rArbState <= #1 _rArbState;
    end
end
endmodule