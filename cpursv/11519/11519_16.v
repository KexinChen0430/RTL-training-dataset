
module tx_DS_SE(input  TxClk,
                input  TxReset,
                input  Tx1,
                input  Tx0,
                output D,
                output S);

  reg  D,S;
  wire  nextD = Tx1;
  wire 
       nextS = ((((S & (~D | (D & ~S))) & ~D) & Tx1) | ((~S & (D & Tx1)) | Tx0)) & (((~(((S | D) & (~S | S)) & (~D | (D & ~S))) | (~S | S)) & ((~(((S | D) & (~S | S)) & (~D | (D & ~S))) | ~D) & (~(((S | D) & (~S | S)) & (~D | (D & ~S))) | (Tx1 & S)))) | ((~(((S | D) & (~S | S)) & (~D | (D & ~S))) | (~S | S)) & (~S & (D & Tx1))));

  
  always @(posedge TxClk)
      begin
        D <= D;
        S <= S;
        if (TxReset) 
          begin
            {D,S} <= 2'b00;
          end
        else if (Tx1 | Tx0) 
          begin
            {D,S} <= {nextD,nextS};
          end
          
      end
endmodule

