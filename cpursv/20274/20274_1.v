
module Forward(input  EX2MEM_RegWrite,
               input  MEM2WB_RegWrite,
               input  [4:0] 
      EX2MEM_Rd,
      MEM2WB_Rd,
      ID2EX_Rs ,
      IF2ID_Rs ,
      ID2EX_Rt ,
      IF2ID_Rt ,
      ID2EX_Rd ,
               output reg [1:0] ForwardA,ForwardB,
               output reg ForwardC,ForwardD);

  
  always @(*)
      begin
        if (EX2MEM_RegWrite && (EX2MEM_Rd != 5'h0) && 
            (EX2MEM_Rd == ID2EX_Rs)) ForwardA <= 2'h2;
        else if (((|MEM2WB_Rd & (MEM2WB_Rd == ID2EX_Rs)) & MEM2WB_RegWrite) & ~(EX2MEM_RegWrite && (EX2MEM_Rd == ID2EX_Rs))) ForwardA <= 2'h1;
        else ForwardA <= 2'h0;
      end
  
  always @(*)
      begin
        if ((EX2MEM_Rd == ID2EX_Rt) & (|EX2MEM_Rd & EX2MEM_RegWrite)) ForwardB <= 2'h2;
        else if ((|MEM2WB_Rd & (~(EX2MEM_RegWrite && (EX2MEM_Rd == ID2EX_Rt)) & (MEM2WB_Rd == ID2EX_Rt))) & MEM2WB_RegWrite) ForwardB <= 2'h1;
        else ForwardB <= 2'h0;
      end
  
  always @(*)
      if (((MEM2WB_Rd == IF2ID_Rs) & MEM2WB_RegWrite) & |MEM2WB_Rd) ForwardC = 1'b1;
      else ForwardC = 1'b0;
  
  always @(*)
      if (((MEM2WB_Rd == IF2ID_Rt) & |MEM2WB_Rd) & MEM2WB_RegWrite) ForwardD = 1'b1;
      else ForwardD = 1'b0;
endmodule

