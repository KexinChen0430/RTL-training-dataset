module alu
  (
   input [2:0]      alu_control,
   input [7:0]      alu_AI,
   input [7:0]      alu_BI,
   input            alu_carry_in,
   output reg [7:0] alu_Y,
   output reg       alu_carry_out,
   output reg       alu_overflow
   );
`include "params.vh"
  reg [8:0]        add_result;  
  reg              add_carry_out;
  reg              add_overflow;
  reg              sr_carry_out;
  always @(*) begin
    case ( alu_control )
      ADD: begin
        add_result = {1'b0, alu_AI} + {1'b0, alu_BI} + {8'd0, alu_carry_in};
        add_carry_out = add_result[8];
        alu_Y = add_result[7:0];
        alu_overflow = add_overflow;
      end
      SR: begin
        alu_Y = {alu_carry_in, alu_AI[7:1]};
        sr_carry_out = alu_AI[0];
        alu_overflow = 1'b0;
      end
      AND: begin
        alu_Y = alu_AI & alu_BI;
        alu_overflow = 1'b0;
      end
      OR: begin
        alu_Y = alu_AI | alu_BI;
        alu_overflow = 1'b0;
      end
      XOR: begin
        alu_Y = alu_AI ^ alu_BI;
        alu_overflow = 1'b0;
      end
      default: begin end
    endcase 
  end
  always @(*) begin
    case ( alu_control )
      ADD: begin
        alu_carry_out = add_carry_out;
      end
      SR: begin
        alu_carry_out = sr_carry_out;
      end
      default: begin
        alu_carry_out = 1'b0;
      end
    endcase 
  end
  always @(*) begin
    add_overflow = (~(alu_AI[7] ^ alu_BI[7])) & (alu_AI[7] ^ alu_Y[7]);
  end
endmodule