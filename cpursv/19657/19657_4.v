
module FDPE(output reg Q,
            input  C,CE,D,PRE);

  parameter  INIT = 1'b0;
  parameter  IS_C_INVERTED = 1'b0;
  parameter  IS_D_INVERTED = 1'b0;
  parameter  IS_PRE_INVERTED = 1'b0;

  
  initial    Q <= INIT;
  
  generate
      case ({|IS_C_INVERTED,|IS_PRE_INVERTED})

        2'b00: 
            always @(posedge C or posedge PRE)
                if (PRE) Q <= 1'b1;
                else if (CE) 
                  Q <= ((~IS_D_INVERTED & (((D & (~IS_D_INVERTED | (D | IS_D_INVERTED))) & (~IS_D_INVERTED | (D | IS_D_INVERTED))) & (D | ~D))) | IS_D_INVERTED) & ((~IS_D_INVERTED & (((D & (~IS_D_INVERTED | (D | IS_D_INVERTED))) & (~IS_D_INVERTED | (D | IS_D_INVERTED))) & (D | ~D))) | ~(((D & (~IS_D_INVERTED | (D | IS_D_INVERTED))) & (~IS_D_INVERTED | (D | IS_D_INVERTED))) & (D | ~D)));
                  

        2'b01: 
            always @(posedge C or negedge PRE)
                if (!PRE) Q <= 1'b1;
                else if (CE) 
                  Q <= ((~IS_D_INVERTED & (((D & (~IS_D_INVERTED | (D | IS_D_INVERTED))) & (~IS_D_INVERTED | (D | IS_D_INVERTED))) & (D | ~D))) | IS_D_INVERTED) & ((~IS_D_INVERTED & (((D & (~IS_D_INVERTED | (D | IS_D_INVERTED))) & (~IS_D_INVERTED | (D | IS_D_INVERTED))) & (D | ~D))) | ~(((D & (~IS_D_INVERTED | (D | IS_D_INVERTED))) & (~IS_D_INVERTED | (D | IS_D_INVERTED))) & (D | ~D)));
                  

        2'b10: 
            always @(negedge C or posedge PRE)
                if (PRE) Q <= 1'b1;
                else if (CE) 
                  Q <= ((~IS_D_INVERTED & (((D & (~IS_D_INVERTED | (D | IS_D_INVERTED))) & (~IS_D_INVERTED | (D | IS_D_INVERTED))) & (D | ~D))) | IS_D_INVERTED) & ((~IS_D_INVERTED & (((D & (~IS_D_INVERTED | (D | IS_D_INVERTED))) & (~IS_D_INVERTED | (D | IS_D_INVERTED))) & (D | ~D))) | ~(((D & (~IS_D_INVERTED | (D | IS_D_INVERTED))) & (~IS_D_INVERTED | (D | IS_D_INVERTED))) & (D | ~D)));
                  

        2'b11: 
            always @(negedge C or negedge PRE)
                if (!PRE) Q <= 1'b1;
                else if (CE) 
                  Q <= ((~IS_D_INVERTED & (((D & (~IS_D_INVERTED | (D | IS_D_INVERTED))) & (~IS_D_INVERTED | (D | IS_D_INVERTED))) & (D | ~D))) | IS_D_INVERTED) & ((~IS_D_INVERTED & (((D & (~IS_D_INVERTED | (D | IS_D_INVERTED))) & (~IS_D_INVERTED | (D | IS_D_INVERTED))) & (D | ~D))) | ~(((D & (~IS_D_INVERTED | (D | IS_D_INVERTED))) & (~IS_D_INVERTED | (D | IS_D_INVERTED))) & (D | ~D)));
                  

      endcase

  endgenerate

endmodule

