
module DFF(output reg Q,
           input  D,
           input  C);

  
  always @(posedge C)  Q <= D;
endmodule

