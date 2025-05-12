
module \$_DFFSRE_PPNN_(C,S,R,E,D,Q);

  input  C,S,R,E,D;
  output reg Q;

  
  always @(posedge C or posedge S or negedge R)
      begin
        if (R == 0) Q <= 0;
        else if (S == 1) Q <= 1;
        else if (E == 0) Q <= D;
          
      end
endmodule

