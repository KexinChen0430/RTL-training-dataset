
module \$_ALDFF_NN_(D,C,L,AD,Q);

  input  D;
  input  C;
  input  L;
  input  AD;
  output reg Q;

  
  always @(negedge C or negedge L)
      begin
        if (L == 0) Q <= AD;
        else Q <= D;
      end
endmodule

