
module \$_DFF_NN1_(D,C,R,Q);

  input  D,C,R;
  output reg Q;

  
  always @(negedge C or negedge R)
      begin
        if (R == 0) Q <= 1;
        else Q <= D;
      end
endmodule

