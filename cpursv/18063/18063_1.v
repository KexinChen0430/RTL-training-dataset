
module \$_ALDFF_NP_(D,C,L,AD,Q);

  input  D;
  input  C;
  input  L;
  input  AD;
  output reg Q;

  
  always @(negedge C or posedge L)
      begin
        if (L == 1) Q <= AD;
        else Q <= D;
      end
endmodule

