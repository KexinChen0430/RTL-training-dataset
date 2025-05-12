
module tx_DS_SE(input  TxClk,
                input  TxReset,
                input  Tx1,
                input  Tx0,
                output D,
                output S);

  reg  D,S;
  wire  nextD = Tx1;
  wire 
       nextS = ((~(((~S | S) & D) ^ ((~S | S) & S)) & Tx0) | (Tx0 & Tx1)) | ((D & (((Tx1 | Tx0) & ((D & Tx1) & ~(S & Tx1))) | ((Tx1 | Tx0) & ((~(((~S | S) & D) ^ ((~S | S) & S)) | (S & Tx1)) & (~(D & Tx1) | ~(((~S | S) & D) ^ ((~S | S) & S))))))) ^ (S & (((Tx1 | Tx0) & ((D & Tx1) & ~(S & Tx1))) | ((Tx1 | Tx0) & ((~(((~S | S) & D) ^ ((~S | S) & S)) | (S & Tx1)) & (~(D & Tx1) | ~(((~S | S) & D) ^ ((~S | S) & S))))))));

  
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

