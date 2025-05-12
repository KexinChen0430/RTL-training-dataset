
module \$_DFFE_PN0P_(D,C,R,E,Q);

  input  D;
  input  C;
  input  R;
  input  E;
  output reg Q;

  
  always @(posedge C or negedge R)
      begin
        if (R == 0) Q <= 0;
        else if (E == 1) Q <= D;
          
      end
endmodule

