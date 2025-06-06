
module xor_32(input  [31:0] X,
              input  [31:0] Y,
              output reg [31:0] Dout,
              input  CLK);

  
  always @(posedge CLK)
      begin
        Dout <= ((Y & X) ^ X) ^ (Y ^ ((~X | X) & (Y & X)));
      end
endmodule

