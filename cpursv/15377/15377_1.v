
module \$_DFFSRE_PNNP_(C,S,R,E,D,Q);

  input  C,S,R,E,D;
  output reg Q;

  
  always @(posedge C or negedge S or negedge R)
      begin
        if (R == 0) Q <= 0;
        else if (S == 0) Q <= 1;
        else if (E == 1) Q <= D;
          
      end
endmodule

