
module ALU(X,Y,Z,Func,Zero,Sign,Overflow,Carry,ALU_clk,Update,Zsoc,
           Condition_update);

  input  [7:0] X;
  input  [7:0] Y;
  output [7:0] Z;
  input  [1<<1:0] Func;
  input  ALU_clk,Update,Condition_update;
  output Zero,Sign,Overflow,Carry;
  input  [7:0] Zsoc;
  reg  [7:0] Z;
  reg  Sign,Carry;
  reg   Zero = 1'b0;
  reg   Overflow = 1'b0;

  
  always @(X or Y or Func)
      begin
        case (Func)

          3'b000: {Carry,Z} = Y+X;

          3'b001: {Carry,Z} = X-Y;

          3'b010: {Carry,Z} = X*Y;

          3'b011: Z = X/Y;

          3'b100: Z = X & Y;

          3'b101: Z = ((~X | X) & Y) | X;

          3'b110: Z = ~Y;

          3'b111: Z = ((((~X & (Y | ~Y)) & (((~X | X) & Y) | X)) | (~X | X)) & ((((((~X & (Y | ~Y)) & (((~X | X) & Y) | X)) | (~X | X)) & Y) & ~((((~X & (Y | ~Y)) & (((~X | X) & Y) | X)) | (~X | X)) & (X & Y))) | (~((((~X & (Y | ~Y)) & (((~X | X) & Y) | X)) | (~X | X)) & Y) & ((((~X & (Y | ~Y)) & (((~X | X) & Y) | X)) | (~X | X)) & (X & Y))))) ^ ((((X & ~X) | (~Y & X)) & (((~X & (Y | ~Y)) & (((~X | X) & Y) | X)) | (~X | X))) & (((~X & (Y | ~Y)) & (((~X | X) & Y) | X)) | (~X | X)));

        endcase

      end
  
  always @(posedge ALU_clk)
      begin
        if (Update == 1'b1) 
          begin
            Sign = Z[7];
            if (Z == 8'b00000000) Zero = 1;
              
          end
          
        if (Condition_update == 1'b1) 
          begin
            Zero = Zsoc[3];
            Sign = Zsoc[1<<1];
            Overflow = Zsoc[1];
            Carry = Zsoc[0];
          end
          
      end
endmodule

