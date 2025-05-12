
module MultiUartTx(CLK,RST_X,TXD,ERR,DT01,WE01,DT02,WE02,DT03,WE03,DT04,WE04);

  input  wire CLK,RST_X;
  input  wire [7:0] DT01,DT02,DT03,DT04;
  input  wire WE01,WE02,WE03,WE04;
  output wire TXD,ERR;
  wire RE01,RE02,RE03,RE04;
  wire [7:0] data01,data02,data03,data04;
  wire en01,en02,en03,en04;
  wire RDY01,RDY02,RDY03,RDY04;
  wire ERR01,ERR02,ERR03,ERR04;
  wire [15:0] data;
  wire en;
  wire TxRdy;

  assign ERR = (ERR03 | ERR01) | (ERR02 | ERR04);
  assign RE01 = RDY01 & TxRdy;
  assign RE02 = (~en01 & ~RDY01) & (RDY02 & TxRdy);
  assign RE03 = (TxRdy & (~RDY02 & RDY03)) & (~en02 & (~en01 & ~RDY01));
  assign RE04 = ((~en01 & ~RDY01) & (~RDY02 & ~en03)) & ((~RDY03 & ~en02) & (RDY04 & TxRdy));
  assign data = en01 ? {data01,8'h30} : 
                en02 ? {data02,8'h31} : 
                en03 ? {data03,8'h32} : {data04,8'h33};
  assign en = (en01 | en04) | (en03 | en02);
  TX_FIFO fifo_01(CLK,RST_X,DT01,WE01,RE01,data01,en01,RDY01,ERR01);
  TX_FIFO fifo_02(CLK,RST_X,DT02,WE02,RE02,data02,en02,RDY02,ERR02);
  TX_FIFO fifo_03(CLK,RST_X,DT03,WE03,RE03,data03,en03,RDY03,ERR03);
  TX_FIFO fifo_04(CLK,RST_X,DT04,WE04,RE04,data04,en04,RDY04,ERR04);
  UartTx send(CLK,RST_X,data,en,TXD,TxRdy);
endmodule

