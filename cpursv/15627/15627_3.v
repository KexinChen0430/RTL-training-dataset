
module two_bit_sat_counter(input  wire [1:0] count_i,
                           input  wire op,
                           output reg [1:0] count);

  
  always @(*)
      begin
        case (count_i)

          2'b00: count = op ? count_i : (2'b1+count_i);

          2'b01: count = op ? ((-2'b1)+count_i) : (2'b1+count_i);

          2'b10: count = op ? (2'b1+count_i) : ((-2'b1)+count_i);

          2'b11: count = op ? count_i : ((-2'b1)+count_i);

          default: count = 2'b0;

        endcase

      end
endmodule

