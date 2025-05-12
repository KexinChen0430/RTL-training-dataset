module SingleUartTx(CLK, RST_X, TXD, ERR, DT01, WE01);
   input  wire       CLK, RST_X;       
   input  wire [7:0] DT01;             
   input  wire       WE01;             
   output wire       TXD, ERR;         
   wire             RE01;              
   wire [7:0]        data01;           
   wire             en01;              
   wire             RDY01;             
   wire             ERR01;             
   wire             TxRdy;             
   assign ERR = ERR01;
   assign RE01 = (RDY01 & TxRdy);
   TX_FIFO fifo_01(
      CLK, RST_X, DT01, WE01, RE01,    
      data01, en01, RDY01, ERR01       
   );
   UartTx send(
      CLK, RST_X, data01, en01, TXD,   
      TxRdy                            
   );
endmodule