
module \$_DFF_PP0_(D,C,R,Q);

  input  D,C,R;
  output reg Q;

  
  always @(posedge C or posedge R)
      begin
        if (R == 1) Q <= 0;
        else Q <= D;
      end
endmodule

