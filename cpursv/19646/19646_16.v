
module FDRE(output reg Q,
            input  C,CE,D,R);

  parameter  INIT = 1'b0;
  parameter  IS_C_INVERTED = 1'b0;
  parameter  IS_D_INVERTED = 1'b0;
  parameter  IS_R_INVERTED = 1'b0;

  
  initial    Q <= INIT;
  
  generate
      case (|IS_C_INVERTED)

        1'b0: 
            always @(posedge C)
                if (R == !IS_R_INVERTED) Q <= 1'b0;
                else if (CE) 
                  Q <= (((((((~D | D) & (D & (IS_D_INVERTED | ~IS_D_INVERTED))) & ~IS_D_INVERTED) & ~(~IS_D_INVERTED & IS_D_INVERTED)) | ~(((~D | D) & (D & (IS_D_INVERTED | ~IS_D_INVERTED))) & ~IS_D_INVERTED)) & (((((~D | D) & (D & (IS_D_INVERTED | ~IS_D_INVERTED))) & ~IS_D_INVERTED) & ~(~IS_D_INVERTED & IS_D_INVERTED)) | (~IS_D_INVERTED & IS_D_INVERTED))) & D) | (~D & IS_D_INVERTED);
                  

        1'b1: 
            always @(negedge C)
                if (R == !IS_R_INVERTED) Q <= 1'b0;
                else if (CE) 
                  Q <= (((((((~D | D) & (D & (IS_D_INVERTED | ~IS_D_INVERTED))) & ~IS_D_INVERTED) & ~(~IS_D_INVERTED & IS_D_INVERTED)) | ~(((~D | D) & (D & (IS_D_INVERTED | ~IS_D_INVERTED))) & ~IS_D_INVERTED)) & (((((~D | D) & (D & (IS_D_INVERTED | ~IS_D_INVERTED))) & ~IS_D_INVERTED) & ~(~IS_D_INVERTED & IS_D_INVERTED)) | (~IS_D_INVERTED & IS_D_INVERTED))) & D) | (~D & IS_D_INVERTED);
                  

      endcase

  endgenerate

endmodule

