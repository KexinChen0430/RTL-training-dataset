
module \$_SDFFE_NP1N_(D,C,R,E,Q);

  input  D;
  input  C;
  input  R;
  input  E;
  output reg Q;

  
  always @(negedge C)
      begin
        if (R == 1) Q <= 1;
        else if (E == 0) Q <= D;
          
      end
endmodule

