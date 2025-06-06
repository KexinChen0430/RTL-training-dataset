
module alu(input  [3:0] op,
           input  [31:0] a,
           input  [31:0] b,
           output reg [31:0] res);

  
  always @(op or a or b)
      begin
        case (op)

          4'b0000: res = b+a;

          4'b0001: res = a-b;

          4'b0010: res = b-a;

          4'b0011: res = a & b;

          4'b0100: res = ((~a | a) & b) | a;

          4'b0101: res = ((((~a | a) & b) | a) & ~a) | ((((~a | a) & b) | a) & ((~b | ~a) & a));

          4'b0110: res = a<<<b;

          4'b0111: res = a>>b;

          4'b1000: res = a>>>b;

          4'b1001: res = b;

          4'b1010: res = {16'd0,b[15:0]};

          4'b1011: res = (b*((1+1)**16)) | a;

          4'b1100: res = a < b;

          4'b1101: res = a <= b;

          4'b1110: res = a == b;

          4'b1111: res = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;

        endcase

      end
endmodule

