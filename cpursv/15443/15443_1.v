
module \$_DLATCH_NN1_(E,R,D,Q);

  input  E,R,D;
  output reg Q;

  
  always @* 
      begin
        if (R == 0) Q <= 1;
        else if (E == 0) Q <= D;
          
      end
endmodule

