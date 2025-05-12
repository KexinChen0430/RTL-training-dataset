module slaveDirectControl (SCTxPortCntl, SCTxPortData, SCTxPortGnt, SCTxPortRdy, SCTxPortReq, SCTxPortWEn, clk, directControlEn, directControlLineState, rst);
input   SCTxPortGnt; 
input   SCTxPortRdy; 
input   clk; 
input   directControlEn; 
input   [1:0] directControlLineState; 
input   rst; 
output  [7:0] SCTxPortCntl; 
output  [7:0] SCTxPortData; 
output  SCTxPortReq; 
output  SCTxPortWEn; 
reg     [7:0] SCTxPortCntl, next_SCTxPortCntl; 
reg     [7:0] SCTxPortData, next_SCTxPortData; 
wire    SCTxPortGnt; 
wire    SCTxPortRdy; 
reg     SCTxPortReq, next_SCTxPortReq; 
reg     SCTxPortWEn, next_SCTxPortWEn; 
wire    clk; 
wire    directControlEn; 
wire    [1:0] directControlLineState; 
wire    rst; 
`define START_SDC 3'b000 
`define CHK_DRCT_CNTL 3'b001 
`define DRCT_CNTL_WAIT_GNT 3'b010 
`define DRCT_CNTL_CHK_LOOP 3'b011 
`define DRCT_CNTL_WAIT_RDY 3'b100 
`define IDLE_FIN 3'b101 
`define IDLE_WAIT_GNT 3'b110 
`define IDLE_WAIT_RDY 3'b111 
reg [2:0] CurrState_slvDrctCntl; 
reg [2:0] NextState_slvDrctCntl; 
always @ (directControlLineState or directControlEn or SCTxPortGnt or SCTxPortRdy or SCTxPortReq or SCTxPortWEn or SCTxPortData or SCTxPortCntl or CurrState_slvDrctCntl)
begin : slvDrctCntl_NextState
  NextState_slvDrctCntl <= CurrState_slvDrctCntl; 
  next_SCTxPortReq <= SCTxPortReq;
  next_SCTxPortWEn <= SCTxPortWEn;
  next_SCTxPortData <= SCTxPortData;
  next_SCTxPortCntl <= SCTxPortCntl;
  case (CurrState_slvDrctCntl) 
  endcase
end
always @ (posedge clk)
begin : slvDrctCntl_CurrentState
  if (rst) 
    CurrState_slvDrctCntl <= `START_SDC; 
  else
    CurrState_slvDrctCntl <= NextState_slvDrctCntl; 
end
always @ (posedge clk)
begin : slvDrctCntl_RegOutput
  if (rst) 
  begin
    SCTxPortCntl <= 8'h00; 
    SCTxPortData <= 8'h00; 
    SCTxPortWEn <= 1'b0; 
    SCTxPortReq <= 1'b0; 
  end
  else
  begin
    SCTxPortCntl <= next_SCTxPortCntl; 
    SCTxPortData <= next_SCTxPortData; 
    SCTxPortWEn <= next_SCTxPortWEn; 
    SCTxPortReq <= next_SCTxPortReq; 
  end
end
endmodule