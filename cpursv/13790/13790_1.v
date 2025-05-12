
module D_flip_flop(output Q,
                   input  D,Clk);

  reg  Q;

  
  initial    Q = 1'b0;
  
  always @(posedge Clk)  Q <= D;
endmodule

