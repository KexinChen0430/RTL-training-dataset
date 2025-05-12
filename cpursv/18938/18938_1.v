
module _DFF_PN1_(D,Q,C,R);

  input  D;
  input  C;
  input  R;
  output reg Q;

  
  always @(posedge C or negedge R)
      begin
        if (R == 0) Q <= 1;
        else Q <= D;
      end
endmodule

