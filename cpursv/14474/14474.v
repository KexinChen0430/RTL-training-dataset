
module \$_DFFE_PN_(D,C,E,Q);

  input  D,C,E;
  output reg Q;

  
  always @(posedge C)
      begin
        if (!E) Q <= D;
          
      end
endmodule

