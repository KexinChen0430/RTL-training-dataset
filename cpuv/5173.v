module sendPacketCheckPreamble (clk, preAmbleEnable, rst, sendPacketCPPID, sendPacketCPReady, sendPacketCPWEn, sendPacketPID, sendPacketRdy, sendPacketWEn);
input   clk;
input   preAmbleEnable;
input   rst;
input   [3:0] sendPacketCPPID;
input   sendPacketCPWEn;
input   sendPacketRdy;
output  sendPacketCPReady;
output  [3:0] sendPacketPID;
output  sendPacketWEn;
wire    clk;
wire    preAmbleEnable;
wire    rst;
wire    [3:0] sendPacketCPPID;
reg     sendPacketCPReady, next_sendPacketCPReady;
wire    sendPacketCPWEn;
reg     [3:0] sendPacketPID, next_sendPacketPID;
wire    sendPacketRdy;
reg     sendPacketWEn, next_sendPacketWEn;
`define SPC_WAIT_EN 4'b0000
`define START_SPC 4'b0001
`define CHK_PREAM 4'b0010
`define PREAM_PKT_SND_PREAM 4'b0011
`define PREAM_PKT_WAIT_RDY1 4'b0100
`define PREAM_PKT_PREAM_SENT 4'b0101
`define PREAM_PKT_SND_PID 4'b0110
`define PREAM_PKT_PID_SENT 4'b0111
`define REG_PKT_SEND_PID 4'b1000
`define REG_PKT_WAIT_RDY1 4'b1001
`define REG_PKT_WAIT_RDY 4'b1010
`define READY 4'b1011
`define PREAM_PKT_WAIT_RDY2 4'b1100
`define PREAM_PKT_WAIT_RDY3 4'b1101
reg [3:0] CurrState_sendPktCP;
reg [3:0] NextState_sendPktCP;
always @ (sendPacketCPPID or sendPacketCPWEn or preAmbleEnable or sendPacketRdy or sendPacketCPReady or sendPacketWEn or sendPacketPID or CurrState_sendPktCP)
begin : sendPktCP_NextState
  NextState_sendPktCP <= CurrState_sendPktCP;
  next_sendPacketCPReady <= sendPacketCPReady;
  next_sendPacketWEn <= sendPacketWEn;
  next_sendPacketPID <= sendPacketPID;
  case (CurrState_sendPktCP)
    `SPC_WAIT_EN:
      if (sendPacketCPWEn == 1'b1)
      begin
        NextState_sendPktCP <= `CHK_PREAM;
        next_sendPacketCPReady <= 1'b0;
      end
    `START_SPC:
      NextState_sendPktCP <= `SPC_WAIT_EN;
    `CHK_PREAM:
      if (preAmbleEnable == 1'b1 && sendPacketCPPID != `SOF)
        NextState_sendPktCP <= `PREAM_PKT_WAIT_RDY1;
      else
        NextState_sendPktCP <= `REG_PKT_WAIT_RDY1;
    `READY:
    begin
      next_sendPacketCPReady <= 1'b1;
      NextState_sendPktCP <= `SPC_WAIT_EN;
    end
    `PREAM_PKT_SND_PREAM:
    begin
      next_sendPacketWEn <= 1'b1;
      next_sendPacketPID <= `PREAMBLE;
      NextState_sendPktCP <= `PREAM_PKT_PREAM_SENT;
    end
    `PREAM_PKT_WAIT_RDY1:
      if (sendPacketRdy == 1'b1)
        NextState_sendPktCP <= `PREAM_PKT_SND_PREAM;
    `PREAM_PKT_PREAM_SENT:
    begin
      next_sendPacketWEn <= 1'b0;
      NextState_sendPktCP <= `PREAM_PKT_WAIT_RDY2;
    end
    `PREAM_PKT_SND_PID:
    begin
      next_sendPacketWEn <= 1'b1;
      next_sendPacketPID <= sendPacketCPPID;
      NextState_sendPktCP <= `PREAM_PKT_PID_SENT;
    end
    `PREAM_PKT_PID_SENT:
    begin
      next_sendPacketWEn <= 1'b0;
      NextState_sendPktCP <= `PREAM_PKT_WAIT_RDY3;
    end
    `PREAM_PKT_WAIT_RDY2:
      if (sendPacketRdy == 1'b1)
        NextState_sendPktCP <= `PREAM_PKT_SND_PID;
    `PREAM_PKT_WAIT_RDY3:
      if (sendPacketRdy == 1'b1)
        NextState_sendPktCP <= `READY;
    `REG_PKT_SEND_PID:
    begin
      next_sendPacketWEn <= 1'b1;
      next_sendPacketPID <= sendPacketCPPID;
      NextState_sendPktCP <= `REG_PKT_WAIT_RDY;
    end
    `REG_PKT_WAIT_RDY1:
      if (sendPacketRdy == 1'b1)
        NextState_sendPktCP <= `REG_PKT_SEND_PID;
    `REG_PKT_WAIT_RDY:
    begin
      next_sendPacketWEn <= 1'b0;
      NextState_sendPktCP <= `READY;
    end
  endcase
end
always @ (posedge clk)
begin : sendPktCP_CurrentState
  if (rst)
    CurrState_sendPktCP <= `START_SPC;
  else
    CurrState_sendPktCP <= NextState_sendPktCP;
end
always @ (posedge clk)
begin : sendPktCP_RegOutput
  if (rst)
  begin
    sendPacketWEn <= 1'b0;
    sendPacketPID <= 4'b0;
    sendPacketCPReady <= 1'b1;
  end
  else
  begin
    sendPacketWEn <= next_sendPacketWEn;
    sendPacketPID <= next_sendPacketPID;
    sendPacketCPReady <= next_sendPacketCPReady;
  end
end
endmodule