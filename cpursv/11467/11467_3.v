
module mult_4_to_1(sel,a_in,b_in,c_in,d_in,out);

  parameter  width = 'd16;
  input  wire [1:0] sel;
  input  wire [(-1)+width:0] a_in,b_in,c_in,d_in;
  output reg [(-1)+width:0] out;

  
  always @(sel or a_in or b_in or c_in or d_in)
      begin
        case (sel)

          2'b00: out[(-1)+width:0] = a_in[(-1)+width:0];

          2'b01: out[(-1)+width:0] = b_in[(-1)+width:0];

          2'b10: out[(-1)+width:0] = c_in[(-1)+width:0];

          2'b11: out[(-1)+width:0] = d_in[(-1)+width:0];

          default: out[(-1)+width:0] = {width{1'b0}};

        endcase

      end
endmodule

