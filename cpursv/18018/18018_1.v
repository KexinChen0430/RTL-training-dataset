
module \$_ALDFFE_NNN_(D,C,L,AD,E,Q);

  input  D;
  input  C;
  input  L;
  input  AD;
  input  E;
  output reg Q;

  
  always @(negedge C or negedge L)
      begin
        if (L == 0) Q <= AD;
        else if (E == 0) Q <= D;
          
      end
endmodule

