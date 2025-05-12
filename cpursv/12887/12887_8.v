
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

  assign z = ~(out[14] | (out[15] | (((out[12] | out[13]) | (out[7] | ((out[10] | out[9]) | ((out[8] | out[6]) | (out[4] | (out[5] | ((out[0] | out[1]) | (out[2] | out[3])))))))) | out[11])));
  
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
                    out <= a+b;
                    out <= a+b;
                  end

              SUB: begin
                    $display(SUB);
                    out <= a-b;
                  end

              MUL: begin
                    $display(MUL);
                    out <= b*a;
                  end

              AND: begin
                    $display(AND);
                    out <= b & a;
                  end

              OR: begin
                    $display(OR);
                    out <= ((a | ~a) & b) | a;
                  end

              NOT: begin
                    $display(NOT);
                    out <= ~a;
                  end

              XOR: begin
                    $display(XOR);
                    out <= ((((a | ~a) | ((((a | ~a) & b) | a) & ~a)) & (b & ((a | ~a) | ((((a | ~a) & b) | a) & ~a)))) & ~(((a & ((((a | ~a) & b) | a) | ~b)) & ((a | ~a) | ((((a | ~a) & b) | a) & ~a))) & ((a | ~a) | ((((a | ~a) & b) | a) & ~a)))) | (~(((a | ~a) | ((((a | ~a) & b) | a) & ~a)) & (b & ((a | ~a) | ((((a | ~a) & b) | a) & ~a)))) & (((a & ((((a | ~a) & b) | a) | ~b)) & ((a | ~a) | ((((a | ~a) & b) | a) & ~a))) & ((a | ~a) | ((((a | ~a) & b) | a) & ~a))));
                  end

              XNOR: begin
                    $display(XNOR);
                    out <= ~(((((a | ~a) | ((((a | ~a) & b) | a) & ~a)) & (b & ((a | ~a) | ((((a | ~a) & b) | a) & ~a)))) & ~(((a & ((((a | ~a) & b) | a) | ~b)) & ((a | ~a) | ((((a | ~a) & b) | a) & ~a))) & ((a | ~a) | ((((a | ~a) & b) | a) & ~a)))) | (~(((a | ~a) | ((((a | ~a) & b) | a) & ~a)) & (b & ((a | ~a) | ((((a | ~a) & b) | a) & ~a)))) & (((a & ((((a | ~a) & b) | a) | ~b)) & ((a | ~a) | ((((a | ~a) & b) | a) & ~a))) & ((a | ~a) | ((((a | ~a) & b) | a) & ~a)))));
                  end

              NAND: begin
                    $display(NAND);
                    out <= ~(b & a);
                  end

              NOR: begin
                    $display(NOR);
                    out <= ~(((a | ~a) & b) | a);
                  end

              LS: begin
                    $display(LS);
                    out <= a*(2**b);
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

