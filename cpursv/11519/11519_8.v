
module tx_DS_SE(input  TxClk,
                input  TxReset,
                input  Tx1,
                input  Tx0,
                output D,
                output S);

  reg  D,S;
  wire  nextD = Tx1;
  wire 
       nextS = (((~S & ((((Tx0 & (~((((((~S | S) & D) | ((~S | S) & S)) & D) & ~S) | ((((~S | S) & D) | ((~S | S) & S)) & ~D)) | (~D & (Tx1 & S)))) | (Tx0 & ((Tx1 & (D & Tx1)) & ~S))) | Tx1) & D)) | ((Tx0 & (~((((((~S | S) & D) | ((~S | S) & S)) & D) & ~S) | ((((~S | S) & D) | ((~S | S) & S)) & ~D)) | (~D & (Tx1 & S)))) | (Tx0 & ((Tx1 & (D & Tx1)) & ~S)))) & (~((((((~S | S) & D) | ((~S | S) & S)) & D) & ~S) | ((((~S | S) & D) | ((~S | S) & S)) & ~D)) | (~S & ((((Tx0 & (~((((((~S | S) & D) | ((~S | S) & S)) & D) & ~S) | ((((~S | S) & D) | ((~S | S) & S)) & ~D)) | (~D & (Tx1 & S)))) | (Tx0 & ((Tx1 & (D & Tx1)) & ~S))) | Tx1) & D)))) | (~D & (Tx1 & S));

  
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

