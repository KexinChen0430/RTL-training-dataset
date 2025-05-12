
module xor_32(input  [31:0] X,
              input  [31:0] Y,
              output reg [31:0] Dout,
              input  CLK);

  
  always @(posedge CLK)
      begin
        Dout <= (((((X & (~X | ~Y)) & (Y | X)) & (~X | X)) & ~((~Y & (((~X | X) & ((~Y | Y) & X)) & Y)) | (~(((~X | X) & ((~Y | Y) & X)) & Y) & Y))) | ((~Y & (((~X | X) & ((~Y | Y) & X)) & Y)) | (~(((~X | X) & ((~Y | Y) & X)) & Y) & Y))) & (((((X & (~X | ~Y)) & (Y | X)) & (~X | X)) & ~((~Y & (((~X | X) & ((~Y | Y) & X)) & Y)) | (~(((~X | X) & ((~Y | Y) & X)) & Y) & Y))) | ~(((X & (~X | ~Y)) & (Y | X)) & (~X | X)));
      end
endmodule

