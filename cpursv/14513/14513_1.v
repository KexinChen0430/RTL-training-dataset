
module \$_DFFSR_PPN_(C,S,R,D,Q);

  input  C,S,R,D;
  output reg Q;

  
  always @(posedge C or posedge S or negedge R)
      begin
        if (R == 0) Q <= 0;
        else if (S == 1) Q <= 1;
        else Q <= D;
      end
endmodule

