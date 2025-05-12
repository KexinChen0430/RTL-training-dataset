
module \$_SR_PN_(S,R,Q);

  input  S,R;
  output reg Q;

  
  always @(posedge S or negedge R)
      begin
        if (R == 0) Q <= 0;
        else if (S == 1) Q <= 1;
          
      end
endmodule

