
module \$_SDFFE_PP0N_(D,C,R,E,Q);

  input  D;
  input  C;
  input  R;
  input  E;
  output reg Q;

  
  always @(posedge C)
      begin
        if (R == 1) Q <= 0;
        else if (E == 0) Q <= D;
          
      end
endmodule

