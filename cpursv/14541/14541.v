
module \$_DFFE_PN1N_(D,C,R,E,Q);

  input  D;
  input  C;
  input  R;
  input  E;
  output reg Q;

  
  always @(posedge C or negedge R)
      begin
        if (R == 0) Q <= 1;
        else if (E == 0) Q <= D;
          
      end
endmodule

