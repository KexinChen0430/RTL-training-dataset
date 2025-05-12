
module tx_DS_SE(input  TxClk,
                input  TxReset,
                input  Tx1,
                input  Tx0,
                output D,
                output S);

  reg  D,S;
  wire  nextD = Tx1;
  wire 
       nextS = ((D & Tx1) & ~(S & Tx1)) | ((((S & Tx1) ^ (D & Tx1)) | ~((((Tx0 | (~D & S)) | (~S & ((~D | D) & (D | S)))) & D) ^ (((Tx0 | (~D & S)) | (~S & ((~D | D) & (D | S)))) & S))) & (Tx0 | ((Tx1 & ~(D & Tx1)) & S)));

  
  always @(posedge TxClk)
      begin
        D <= D;
        S <= S;
        if (TxReset) 
          begin
            {D,S} <= 2'b00;
          end
        else if (Tx0 | Tx1) 
          begin
            {D,S} <= {nextD,nextS};
          end
          
      end
endmodule

