
module \$_SDFFE_PN0N_(D,C,R,E,Q);

  input  D,C,R,E;
  output reg Q;

  
  always @(posedge C)
      begin
        if (R == 0) Q <= 0;
        else if (E == 0) Q <= D;
          
      end
endmodule

