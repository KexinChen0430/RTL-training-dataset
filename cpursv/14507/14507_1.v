
module \$_DFFE_NN1N_(D,C,R,E,Q);

  input  D,C,R,E;
  output reg Q;

  
  always @(negedge C or negedge R)
      begin
        if (R == 0) Q <= 1;
        else if (E == 0) Q <= D;
          
      end
endmodule

