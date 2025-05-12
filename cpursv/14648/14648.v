
module \$_SDFF_NP1_(D,C,R,Q);

  input  D,C,R;
  output reg Q;

  
  always @(negedge C)
      begin
        if (R == 1) Q <= 1;
        else Q <= D;
      end
endmodule

