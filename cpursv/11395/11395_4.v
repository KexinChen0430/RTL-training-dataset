
module mult_2_to_1(sel,a_in,b_in,out);

  parameter  width = 'd16;
  input  wire sel;
  input  wire [(0-1)+width:0] a_in,b_in;
  output reg [(0-1)+width:0] out;

  
  always @(sel or a_in or b_in)
      begin
        case (sel)

          1'b0: out[(0-1)+width:0] = a_in[(0-1)+width:0];

          1'b1: out[(0-1)+width:0] = b_in[(0-1)+width:0];

          default: out[(0-1)+width:0] = {width{1'b0}};

        endcase

      end
endmodule

