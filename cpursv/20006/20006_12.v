
module b_left_shifter_new(shift_in,shift_value,shift_out);

  input  [55:0] shift_in;
  input  [5:0] shift_value;
  output [55:0] shift_out;
  reg  [55:0] shift_out;

  
  always @(shift_value)
      begin
        case (shift_value)

          6'b000000: shift_out = shift_in;

          6'b000001: shift_out = shift_in<<<1;

          6'b000010: shift_out = shift_in<<2;

          6'b110111: shift_out = shift_in<<<55;

          6'b111000: shift_out = shift_in<<<56;

        endcase

      end
endmodule

