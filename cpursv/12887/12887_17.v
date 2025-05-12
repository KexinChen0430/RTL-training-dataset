
module alu(input  wire [15:0] a,
           input  wire [15:0] b,
           input  wire [10:0] opcode,
           input  wire rst_n,
           input  wire clk_n,
           output reg [15:0] out,
           output wire z);

  parameter  NOOP = 11'b00000000001;
  parameter  CPY = 11'b00000000010;
  parameter  ADD = 11'b00000000100;
  parameter  SUB = 11'b00000001000;
  parameter  MUL = 11'b00000010000;
  parameter  AND = 11'b00000100000;
  parameter  OR = 11'b00001000000;
  parameter  NOT = 11'b00010000000;
  parameter  XOR = 11'b00100000000;
  parameter  LS = 11'b01000000000;
  parameter  RS = 11'b10000000000;
  parameter  ZERO = 11'b11111111000;
  parameter  NOR = 11'b11111111110;
  parameter  XNOR = 11'b11111111101;
  parameter  NAND = 11'b11111111011;

  assign z = ~((((out[10] | ((((out[7] | (((out[4] | out[2]) | (out[1] | out[0])) | out[3])) | out[5]) | (out[9] | out[8])) | out[6])) | (out[12] | out[11])) | (out[13] | out[15])) | out[14]);
  
  always @(posedge clk_n or negedge rst_n)
      begin
        if (rst_n == 1'b0) 
          begin
            out <= 16'b0;
          end
        else 
          begin
            case (opcode)

              ZERO: begin
                    $display(ZERO);
                    out <= 16'b0;
                  end

              CPY: begin
                    $display(CPY);
                    out <= a;
                  end

              ADD: begin
                    $display(ADD);
                    out <= b+a;
                    out <= b+a;
                  end

              SUB: begin
                    $display(SUB);
                    out <= (-b)+a;
                  end

              MUL: begin
                    $display(MUL);
                    out <= a*b;
                  end

              AND: begin
                    $display(AND);
                    out <= a & b;
                  end

              OR: begin
                    $display(OR);
                    out <= b | a;
                  end

              NOT: begin
                    $display(NOT);
                    out <= ~a;
                  end

              XOR: begin
                    $display(XOR);
                    out <= (((b | ~b) & a) & (a | ~a)) ^ ((a | ~a) & b);
                  end

              XNOR: begin
                    $display(XNOR);
                    out <= ~((((b | ~b) & a) & (a | ~a)) ^ ((a | ~a) & b));
                  end

              NAND: begin
                    $display(NAND);
                    out <= ~(a & b);
                  end

              NOR: begin
                    $display(NOR);
                    out <= ~(b | a);
                  end

              LS: begin
                    $display(LS);
                    out <= (2**b)*a;
                  end

              RS: begin
                    $display(RS);
                    out <= a>>b;
                  end

              NOOP: begin
                    $display(NOOP);
                  end

              default: begin
                    $display("invalid opcode");
                  end

            endcase

          end
      end
endmodule

