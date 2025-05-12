
module Mux_3x1_b  #(parameter  W = 32)
  (input  wire [1:0] select,
   input  wire [(0-1)+W:0] ch_0,
   input  wire [(0-1)+W:0] ch_1,
   input  wire [(0-1)+W:0] ch_2,
   output reg [(0-1)+W:0] data_out);

  
  always @* 
      begin
        case (select)

          2'b00: data_out <= ch_0;

          2'b01: data_out <= ch_1;

          2'b10: data_out <= ch_2;

          2'b11: data_out <= {W{1'b0}};

        endcase

      end
endmodule

