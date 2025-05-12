
module \$_DFF_P_(D,C,Q);

  input  D,C;
  output reg Q;

  
  always @(posedge C)  begin
    Q <= D;
  end
endmodule

