
module alu(a,b,aluc,result);

  input  wire [31:0] a,b;
  input  wire [4:0] aluc;
  output reg [31:0] result;

  
  always @* 
      begin
        case (aluc)

          5'd0: result = b+a;

          5'd1: result = b+a;

          5'd2: result = a-b;

          5'd3: result = a-b;

          5'd4: result = b & a;

          5'd5: result = b | ((b | ~b) & a);

          5'd6: result = (~b & a) | (((a & ((((b | ~b) & a) & (((b | ~b) & a) & b)) ^ (((b | ~b) & a) & b))) ^ (a & (((b & a) & b) ^ b))) ^ (((b & a) & b) ^ b));

          5'd7: result = ~(b | ((b | ~b) & a));

          5'd8: result = ((b[31] & ~a[31]) | ((~a[31] | (~b[31] & a[31])) & (a[31] & (~b[31] | b[31])))) ? (a[31] ? 1 : 0) : (a < b);

          5'd9: result = a < b;

          5'd10: result = b<<a;

          5'd11: result = b>>a;

          5'd12: begin
                case (a[4:0])

                  5'd0: result = b;

                  5'd1: result = {b[31],b[31:1]};

                  5'd31: result = {32{b[31]}};

                endcase

              end

          5'd14: result = {b[15:0],16'b0};

          default: begin
                result = 0;
              end

        endcase

      end
endmodule

