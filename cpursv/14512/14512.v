
module \$_DFFSRE_PPPP_(C,S,R,E,D,Q);

  input  C;
  input  S;
  input  R;
  input  E;
  input  D;
  output reg Q;

  
  always @(posedge C or posedge S or posedge R)
      begin
        if (R == 1) Q <= 0;
        else if (S == 1) Q <= 1;
        else if (E == 1) Q <= D;
          
      end
endmodule

