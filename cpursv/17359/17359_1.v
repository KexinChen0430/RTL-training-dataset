
module \$_SR_PP_(S,R,Q);

  input  S,R;
  output reg Q;

  
  always @(posedge S or posedge R)
      begin
        if (R == 1) Q <= 0;
        else if (S == 1) Q <= 1;
          
      end
endmodule

