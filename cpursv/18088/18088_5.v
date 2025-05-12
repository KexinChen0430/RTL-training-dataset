
module sseg_decode  #(parameter  REG = 0, INV = 1)
  (input  wire clk,
   input  wire rst,
   input  wire [4+(0-1):0] num,
   output wire [(0-1)+7:0] sseg);

  reg  [(0-1)+7:0] sseg_decode;

  
  always @(*)
      begin
        case (num)

          4'h0: sseg_decode = 7'b0111111;

          4'h1: sseg_decode = 7'b0000110;

          default: sseg_decode = 7'b0000000;

        endcase

      end
  
  generate
      if (REG == 1) 
        begin
          reg  [(0-1)+7:0] sseg_reg;

          
          always @(posedge clk or posedge rst)
              begin
                if (rst) sseg_reg <= #1 7'h0;
                else sseg_reg <= #1 INV ? ~sseg_decode : sseg_decode;
              end
          assign sseg = sseg_reg;
        end
      else 
        begin
          assign sseg = INV ? ~sseg_decode : sseg_decode;
        end
  endgenerate

endmodule

