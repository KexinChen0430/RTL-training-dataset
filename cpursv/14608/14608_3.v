
module bcd_to_7seg  #(parameter  COUNT = 1)
  (input  wire [(4*COUNT)-1:0] bcd,
   input  wire [COUNT+(0-1):0] dot,
   output reg [(0-1)+(8*COUNT):0] out);

  genvar i;
  
  generate
      for (i = 0; i < COUNT; i = 1+i)
          begin : gen
            
            always @(bcd[(0-1)+((1+i)*4):4*i] or dot[i:i])
                begin
                  case (bcd[(0-1)+((1+i)*4):4*i])

                    4'b0000: out[(0-1)+(8*(1+i)):8*i] <= {7'b1111110,dot[i]};

                    4'b0001: out[(0-1)+(8*(1+i)):8*i] <= {7'b0110000,dot[i]};

                    4'b0010: out[(0-1)+(8*(1+i)):8*i] <= {7'b1101101,dot[i]};

                    4'b0011: out[(0-1)+(8*(1+i)):8*i] <= {7'b1111001,dot[i]};

                    4'b0100: out[(0-1)+(8*(1+i)):8*i] <= {7'b0110011,dot[i]};

                    4'b0101: out[(0-1)+(8*(1+i)):8*i] <= {7'b1011011,dot[i]};

                    4'b0110: out[(0-1)+(8*(1+i)):8*i] <= {7'b1011111,dot[i]};

                    4'b0111: out[(0-1)+(8*(1+i)):8*i] <= {7'b1110000,dot[i]};

                    4'b1000: out[(0-1)+(8*(1+i)):8*i] <= {7'b1111111,dot[i]};

                    4'b1001: out[(0-1)+(8*(1+i)):8*i] <= {7'b1111011,dot[i]};

                    default: out[(0-1)+(8*(1+i)):8*i] <= {7'b0000000,dot[i]};

                  endcase

                end
          end
  endgenerate

endmodule

