module mips_decode(  
  ctrl_we, ctrl_Sys, ctrl_RI, alu__sel, isImm,  
  dcd_op, dcd_funct2  
  );
  input       [5:0] dcd_op, dcd_funct2;  
  output reg        ctrl_we, ctrl_Sys, ctrl_RI, isImm;  
  output reg  [3:0] alu__sel;  
  always @(*) begin  
    alu__sel = 4'hx;  
    ctrl_we = 1'b0;  
    ctrl_Sys = 1'b0;  
    ctrl_RI = 1'b0;  
    isImm = 1'bx;  
    case(dcd_op)  
      `OP_OTHER0:  
        case(dcd_funct2)  
          `OP0_ADD:  
          begin
            alu__sel = `ALU_ADD;  
            ctrl_we = 1'b1;  
            isImm = 1'b0;  
          end
          `OP0_SYSCALL:  
            ctrl_Sys = 1'b1;  
          default:  
            ctrl_RI = 1'b1;  
        endcase
      `OP_ADDIU:  
        begin
          alu__sel = `ALU_ADD;  
          ctrl_we = 1'b1;  
          isImm = 1'b1;  
        end
      default:  
        begin
          ctrl_RI = 1'b1;  
        end
    endcase 
  end
endmodule  