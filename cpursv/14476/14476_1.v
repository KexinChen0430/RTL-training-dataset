
module \$_DFF_NP1_(D,C,R,Q);

  input  D;
  input  C;
  input  R;
  output reg Q;

  
  always @(negedge C or posedge R)
      begin
        if (R == 1) Q <= 1;
        else Q <= D;
      end
endmodule

