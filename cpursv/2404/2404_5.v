
module pselect_f(A,AValid,CS);

  parameter  C_AB = 9;
  parameter  C_AW = 32;
  parameter [0:C_AW+(-1)]  C_BAR = 'bz;
  parameter  C_FAMILY = nofamily;
  input  [0:C_AW+(-1)] A;
  input  AValid;
  output CS;
  wire CS;
  parameter [0:(-1)+C_AB]  BAR = C_BAR[0:(-1)+C_AB];

  
  generate
      if (C_AB > 0) 
        begin : XST_WA
          assign CS = (A[0:(-1)+C_AB] == BAR[0:(-1)+C_AB]) ? AValid : 1'b0;
        end
        
  endgenerate

  
  generate
      if (C_AB == 0) 
        begin : PASS_ON_GEN
          assign CS = AValid;
        end
        
  endgenerate

endmodule

