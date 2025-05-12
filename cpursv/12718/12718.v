
module RegisterFile(output reg [15:0] A_Data,B_Data,
                    input  [15:0] D_Data,
                    input  [2:0] AA,BA,DA,
                    input  RW,CLK);

  reg  [15:0] REGS[7:0];

  
  always @(posedge CLK)
      if (RW) 
        case (DA)

          3'b000: REGS[0] = D_Data;

          3'b001: REGS[1] = D_Data;

          3'b010: REGS[2] = D_Data;

          3'b011: REGS[3] = D_Data;

          3'b100: REGS[4] = D_Data;

          3'b101: REGS[5] = D_Data;

          3'b110: REGS[6] = D_Data;

          3'b111: REGS[7] = D_Data;

        endcase

        
  
  always @(*)
      begin
        case (AA)

          3'b000: A_Data = REGS[0];

          3'b001: A_Data = REGS[1];

          3'b010: A_Data = REGS[2];

          3'b011: A_Data = REGS[3];

          3'b100: A_Data = REGS[4];

          3'b101: A_Data = REGS[5];

          3'b110: A_Data = REGS[6];

          3'b111: A_Data = REGS[7];

        endcase

        case (BA)

          3'b000: B_Data = REGS[0];

          3'b001: B_Data = REGS[1];

          3'b010: B_Data = REGS[2];

          3'b011: B_Data = REGS[3];

          3'b100: B_Data = REGS[4];

          3'b101: B_Data = REGS[5];

          3'b110: B_Data = REGS[6];

          3'b111: B_Data = REGS[7];

        endcase

      end
endmodule

