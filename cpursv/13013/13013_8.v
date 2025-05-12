
module alu(a,b,aluc,result);

  input  wire [31:0] a,b;
  input  wire [4:0] aluc;
  output reg [31:0] result;

  
  always @* 
      begin
        case (aluc)

          5'd0: begin
                result = b+a;
              end

          5'd1: begin
                result = a+(0-b);
              end

          5'd2: begin
                result = b & a;
              end

          5'd3: begin
                result = b | a;
              end

          5'd6: begin
                result = b<<a;
              end

          5'd10: begin
                result = b>>a;
              end

          5'd8: begin
                case (a[4:0])

                  5'd0: result = b;

                  5'd1: result = {b[31],b[31:1]};

                  5'd2: result = {{1<<1{b[31]}},b[31:1<<1]};

                  5'd3: result = {{3{b[31]}},b[31:3]};

                  5'd31: result = {32{b[31]}};

                endcase

              end

          default: begin
                result = 0;
              end

        endcase

      end
endmodule

