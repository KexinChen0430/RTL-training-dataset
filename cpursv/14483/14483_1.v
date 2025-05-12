
module \$_DFFSR_NPP_(C,S,R,D,Q);

  input  C,S,R,D;
  output reg Q;

  
  always @(negedge C or posedge S or posedge R)
      begin
        if (R == 1) Q <= 0;
        else if (S == 1) Q <= 1;
        else Q <= D;
      end
endmodule

