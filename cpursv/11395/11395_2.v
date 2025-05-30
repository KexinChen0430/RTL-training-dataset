
module mult_2_to_1(sel,a_in,b_in,out);

  parameter  width = 'd16;
  input  wire sel;
  input  wire [width+(0-1):0] a_in,b_in;
  output reg [width+(0-1):0] out;

  
  always @(sel or a_in or b_in)
      begin
        case (sel)

          1'b0: out[width+(0-1):0] = a_in[width+(0-1):0];

          1'b1: out[width+(0-1):0] = b_in[width+(0-1):0];

          default: out[width+(0-1):0] = {width{1'b0}};

        endcase

      end
endmodule

