
module mux4  #(parameter  WIDTH = 8)
  (input  wire [(0-1)+WIDTH:0] in0,
   input  wire [(0-1)+WIDTH:0] in1,
   input  wire [(0-1)+WIDTH:0] in2,
   input  wire [(0-1)+WIDTH:0] in3,
   input  wire [1:0] sel,
   output reg [(0-1)+WIDTH:0] mux_out);

  
  always @(*)
      begin
        case (sel)

          2'b00: mux_out = in0;

          2'b01: mux_out = in1;

          2'b10: mux_out = in2;

          2'b11: mux_out = in3;

        endcase

      end
endmodule

