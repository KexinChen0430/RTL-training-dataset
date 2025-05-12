
module \$_SDFFE_PP0P_(D,C,R,E,Q);

  input  D;
  input  C;
  input  R;
  input  E;
  output reg Q;

  
  always @(posedge C)
      begin
        if (R == 1) Q <= 0;
        else if (E == 1) Q <= D;
          
      end
endmodule

