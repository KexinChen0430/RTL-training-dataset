
module \$_SDFFE_NP0P_(D,C,R,E,Q);

  input  D;
  input  C;
  input  R;
  input  E;
  output reg Q;

  
  always @(negedge C)
      begin
        if (R == 1) Q <= 0;
        else if (E == 1) Q <= D;
          
      end
endmodule

