
module decoder_6b_40b_en(addr_in,en,out);

  input  [5:0] addr_in;
  wire [5:0] addr_in;
  output [39:0] out;
  wire [39:0] out;
  input  en;
  wire en;
  reg  [39:0] decoded_out;

  
  always @(addr_in)
      begin
        decoded_out = 40'd0;
        case (addr_in)

          0: decoded_out[0] = 1'b1;

          1: decoded_out[1] = 1'b1;

          default: decoded_out = 40'd0;

        endcase

      end
  assign out = en ? decoded_out : 40'd0;
endmodule

