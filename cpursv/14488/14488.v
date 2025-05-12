
module \$_DFFSRE_NNPP_(C,S,R,E,D,Q);

  input  C,S,R,E,D;
  output reg Q;

  
  always @(negedge C or negedge S or posedge R)
      begin
        if (R == 1) Q <= 0;
        else if (S == 0) Q <= 1;
        else if (E == 1) Q <= D;
          
      end
endmodule

