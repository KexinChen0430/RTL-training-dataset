
module alu(input  [3:0] ctl,
           input  [31:0] a,b,
           output reg [31:0] out,
           output zero);

  wire [31:0] sub_ab;
  wire [31:0] add_ab;
  wire oflow_add;
  wire oflow_sub;
  wire oflow;
  wire slt;

  assign zero = 0 == out;
  assign sub_ab = (0-b)+a;
  assign add_ab = a+b;
  assign oflow_add = ((add_ab[31] != a[31]) && (a[31] == b[31])) ? 1 : 0;
  assign oflow_sub = ((a[31] == b[31]) && (sub_ab[31] != a[31])) ? 1 : 0;
  assign oflow = (ctl == 4'b0010) ? oflow_add : oflow_sub;
  assign slt = oflow_sub ? ~a[31] : a[31];
  
  always @(*)
      begin
        case (ctl)

          4'b0010: out <= add_ab;

          4'b0000: out <= a & b;

          4'b1100: out <= ~(b | a);

          4'b0001: out <= b | a;

          4'b0111: out <= {{31{1'b0}},slt};

          4'b0110: out <= sub_ab;

          4'b1101: out <= (((b | a) & ~a) | ((a & (b | ~b)) & (~b | ~a))) & (~b | ~a);

          default: out <= 0;

        endcase

      end
endmodule

