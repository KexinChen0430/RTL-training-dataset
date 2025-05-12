
module shifter(A,B,factor);

  input  [(0-1)+64:0] A;
  output [(0-1)+64:0] B;
  reg  [(0-1)+64:0] B;
  input  [1:0] factor;

  
  always @(factor or A)
      begin
        case (factor)

          2'b00: begin
                B = A;
              end

          2'b01: begin
                B = {4'b0000,A[(0-1)+64:4]};
              end

          2'b10: begin
                B = {8'b00000000,A[(0-1)+64:8]};
              end

          2'b11: begin
                B = {12'b000000000000,A[(0-1)+64:12]};
              end

        endcase

      end
endmodule

