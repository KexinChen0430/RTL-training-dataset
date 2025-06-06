
module b_left_shifter(shift_in,shift_value,shift_out);

  input  [47:0] shift_in;
  input  [5:0] shift_value;
  output [47:0] shift_out;
  reg  [47:0] shift_out;

  
  always @(shift_value)
      begin
        case (shift_value)

          6'b000000: shift_out = shift_in;

          6'b000001: shift_out = shift_in*2;

        endcase

      end
endmodule

