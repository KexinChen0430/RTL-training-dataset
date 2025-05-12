module SCTxPortArbiter (
    SCTxPortCntl, SCTxPortData, SCTxPortRdyIn, SCTxPortRdyOut, SCTxPortWEnable,
    clk, directCntlCntl, directCntlData, directCntlGnt, directCntlReq, directCntlWEn,
    rst, sendPacketCntl, sendPacketData, sendPacketGnt, sendPacketReq, sendPacketWEn
);
input   SCTxPortRdyIn;
input   clk;
input   [7:0] directCntlCntl;
input   [7:0] directCntlData;
input   directCntlReq;
input   directCntlWEn;
input   rst;
input   [7:0] sendPacketCntl;
input   [7:0] sendPacketData;
input   sendPacketReq;
input   sendPacketWEn;
output  [7:0] SCTxPortCntl;
output  [7:0] SCTxPortData;
output  SCTxPortRdyOut;
output  SCTxPortWEnable;
output  directCntlGnt;
output  sendPacketGnt;
reg     [7:0] SCTxPortCntl, next_SCTxPortCntl;
reg     [7:0] SCTxPortData, next_SCTxPortData;
wire    SCTxPortRdyIn; 
reg     SCTxPortRdyOut, next_SCTxPortRdyOut;
reg     SCTxPortWEnable, next_SCTxPortWEnable;
wire    clk; 
wire    [7:0] directCntlCntl; 
wire    [7:0] directCntlData; 
reg     directCntlGnt, next_directCntlGnt;
wire    directCntlReq; 
wire    directCntlWEn; 
wire    rst; 
wire    [7:0] sendPacketCntl; 
wire    [7:0] sendPacketData; 
reg     sendPacketGnt, next_sendPacketGnt;
wire    sendPacketReq; 
wire    sendPacketWEn; 
reg  muxDCEn, next_muxDCEn;
`define SARB1_WAIT_REQ 2'b00
`define SARB_SEND_PACKET 2'b01
`define SARB_DC 2'b10
`define START_SARB 2'b11
reg [1:0] CurrState_SCTxArb;
reg [1:0] NextState_SCTxArb;
always @(SCTxPortRdyIn)
begin
    SCTxPortRdyOut <= SCTxPortRdyIn;
end
always @(muxDCEn or
         directCntlWEn or directCntlData or directCntlCntl or
         sendPacketWEn or sendPacketData or sendPacketCntl)
begin
    if (muxDCEn == 1'b1)
    begin
        SCTxPortWEnable <= directCntlWEn;
        SCTxPortData <= directCntlData;
        SCTxPortCntl <= directCntlCntl;
    end
    else
    begin
        SCTxPortWEnable <= sendPacketWEn;
        SCTxPortData <= sendPacketData;
        SCTxPortCntl <= sendPacketCntl;
    end
end
always @ (sendPacketReq or directCntlReq or sendPacketGnt or muxDCEn or directCntlGnt or CurrState_SCTxArb)
begin : SCTxArb_NextState
    NextState_SCTxArb <= CurrState_SCTxArb; 
    next_sendPacketGnt <= sendPacketGnt;
    next_muxDCEn <= muxDCEn;
    next_directCntlGnt <= directCntlGnt;
    case (CurrState_SCTxArb)
        `SARB1_WAIT_REQ:
            if (sendPacketReq == 1'b1)
            begin
                NextState_SCTxArb <= `SARB_SEND_PACKET;
                next_sendPacketGnt <= 1'b1;
                next_muxDCEn <= 1'b0;
            end
            else if (directCntlReq == 1'b1)
            begin
                NextState_SCTxArb <= `SARB_DC;
                next_directCntlGnt <= 1'b1;
                next_muxDCEn <= 1'b1;
            end
        `SARB_SEND_PACKET:
            if (sendPacketReq == 1'b0)
            begin
                NextState_SCTxArb <= `SARB1_WAIT_REQ;
                next_sendPacketGnt <= 1'b0;
            end
        `SARB_DC:
            if (directCntlReq == 1'b0)
            begin
                NextState_SCTxArb <= `SARB1_WAIT_REQ;
                next_directCntlGnt <= 1'b0;
            end
        `START_SARB:
            NextState_SCTxArb <= `SARB1_WAIT_REQ;
    endcase
end
always @ (posedge clk)
begin : SCTxArb_CurrentState
    if (rst)
        CurrState_SCTxArb <= `START_SARB; 
    else
        CurrState_SCTxArb <= NextState_SCTxArb; 
end
always @ (posedge clk)
begin : SCTxArb_RegOutput
    if (rst)
    begin
        muxDCEn <= 1'b0;
        sendPacketGnt <= 1'b0;
        directCntlGnt <= 1'b0;
    end
    else
    begin
        muxDCEn <= next_muxDCEn;
        sendPacketGnt <= next_sendPacketGnt;
        directCntlGnt <= next_directCntlGnt;
    end
end
endmodule