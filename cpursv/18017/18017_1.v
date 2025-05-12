
module \$_ALDFFE_NPN_(D,C,L,AD,E,Q);

  input  D;
  input  C;
  input  L;
  input  AD;
  input  E;
  output reg Q;

  
  always @(negedge C or posedge L)
      begin
        if (L == 1) Q <= AD;
        else if (E == 0) Q <= D;
          
      end
endmodule

