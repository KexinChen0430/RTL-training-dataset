
module \$_ALDFF_PN_(D,C,L,AD,Q);

  input  D,C,L,AD;
  output reg Q;

  
  always @(posedge C or negedge L)
      begin
        if (L == 0) Q <= AD;
        else Q <= D;
      end
endmodule

