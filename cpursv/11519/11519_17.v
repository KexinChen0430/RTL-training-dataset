
module tx_DS_SE(input  TxClk,
                input  TxReset,
                input  Tx1,
                input  Tx0,
                output D,
                output S);

  reg  D,S;
  wire  nextD = Tx1;
  wire 
       nextS = ((((~S & D) | ((~(((D | ~D) & ((((~S & D) | ~D) | (S & ((~S & D) | ~D))) & D)) ^ ((D | ~D) & ((((~S & D) | ~D) | (S & ((~S & D) | ~D))) & S))) | (~D & S)) & (Tx0 | (~D & S)))) & ((~D | ~(((D | ~D) & ((((~S & D) | ~D) | (S & ((~S & D) | ~D))) & D)) ^ ((D | ~D) & ((((~S & D) | ~D) | (S & ((~S & D) | ~D))) & S)))) & (~(((D | ~D) & ((((~S & D) | ~D) | (S & ((~S & D) | ~D))) & D)) ^ ((D | ~D) & ((((~S & D) | ~D) | (S & ((~S & D) | ~D))) & S))) | (S & Tx1)))) | (((~S & D) | ((~(((D | ~D) & ((((~S & D) | ~D) | (S & ((~S & D) | ~D))) & D)) ^ ((D | ~D) & ((((~S & D) | ~D) | (S & ((~S & D) | ~D))) & S))) | (~D & S)) & (Tx0 | (~D & S)))) & (~S & (Tx1 & D)))) & (((Tx1 & ((~(((D | ~D) & ((((~S & D) | ~D) | (S & ((~S & D) | ~D))) & D)) ^ ((D | ~D) & ((((~S & D) | ~D) | (S & ((~S & D) | ~D))) & S))) | (~D & S)) & (Tx0 | (~D & S)))) | (~S & (Tx1 & D))) | Tx0);

  
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

