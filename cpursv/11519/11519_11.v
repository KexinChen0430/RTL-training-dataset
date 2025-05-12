
module tx_DS_SE(input  TxClk,
                input  TxReset,
                input  Tx1,
                input  Tx0,
                output D,
                output S);

  reg  D,S;
  wire  nextD = Tx1;
  wire 
       nextS = ((Tx1 & (((((Tx0 | (~S & D)) | S) & ((~((~S & D) | (((D | S) & (S | ~S)) & ~D)) | (D | S)) & ((D | ~D) | ~((~S & D) | (((D | S) & (S | ~S)) & ~D))))) & (~((~S & D) | (((D | S) & (S | ~S)) & ~D)) | (~S & D))) & (Tx0 | (~S & D)))) | (((((~((~S & D) | (((D | S) & (S | ~S)) & ~D)) | (D | S)) & ((D | ~D) | ~((~S & D) | (((D | S) & (S | ~S)) & ~D)))) & (~((~S & D) | (((D | S) & (S | ~S)) & ~D)) | ((Tx1 & ~S) | (Tx1 & ~D)))) & S) & (Tx1 & ~D))) | ((((~S | ~((~S & D) | (((D | S) & (S | ~S)) & ~D))) & (~S | ((((~((~S & D) | (((D | S) & (S | ~S)) & ~D)) | (D | S)) & ((D | ~D) | ~((~S & D) | (((D | S) & (S | ~S)) & ~D)))) & (~((~S & D) | (((D | S) & (S | ~S)) & ~D)) | ((Tx1 & ~S) | (Tx1 & ~D)))) & Tx0))) & ~((~S & D) | (((D | S) & (S | ~S)) & ~D))) & ((((~((~S & D) | (((D | S) & (S | ~S)) & ~D)) | (D | S)) & ((D | ~D) | ~((~S & D) | (((D | S) & (S | ~S)) & ~D)))) & (~((~S & D) | (((D | S) & (S | ~S)) & ~D)) | ((Tx1 & ~S) | (Tx1 & ~D)))) & Tx0));

  
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

