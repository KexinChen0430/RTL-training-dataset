
module eightbit_alu(input  signed  [7:0] a,
                    input  signed  [7:0] b,
                    input  [2:0] sel,
                    output reg signed  [7:0] f,
                    output reg ovf,
                    output reg zero);

  
  always @(a or b or sel)
      begin
        zero = 0;
        ovf = 0;
        f = 0;
        case (sel)

          3'b000: begin
                f = b+a;
                ovf = ((f[7] | ~f[7]) & (f[7] | ((((f[7] | ~f[7]) & a[7]) & (~a[7] | ~f[7])) & ~((~a[7] & b[7]) | ((~a[7] | ((a[7] | b[7]) & ~b[7])) & (a[7] & (b[7] | ~b[7]))))))) & ((~((~a[7] & b[7]) | ((~a[7] | ((a[7] | b[7]) & ~b[7])) & (a[7] & (b[7] | ~b[7])))) & ~a[7]) | ((~f[7] & (~((~a[7] & b[7]) | ((~a[7] | ((a[7] | b[7]) & ~b[7])) & (a[7] & (b[7] | ~b[7])))) | (a[7] & ~f[7]))) & ~((~a[7] & b[7]) | ((~a[7] | ((a[7] | b[7]) & ~b[7])) & (a[7] & (b[7] | ~b[7]))))));
              end

          3'b001: begin
                f = ~b;
              end

          3'b010: begin
                f = b & a;
              end

          3'b011: begin
                f = a | b;
              end

          3'b100: begin
                f = a>>>1;
              end

          3'b101: begin
                f = a<<<1;
              end

          3'b110: begin
                zero = a == b;
              end

          3'b111: begin
                zero = a != b;
              end

        endcase

      end
endmodule

