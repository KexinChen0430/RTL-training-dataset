
module \$_SDFF_PN1_(D,C,R,Q);

  input  D,C,R;
  output reg Q;

  
  always @(posedge C)
      begin
        if (R == 0) Q <= 1;
        else Q <= D;
      end
endmodule

