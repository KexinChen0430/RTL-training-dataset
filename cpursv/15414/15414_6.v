
module b_left_shifter_new(shift_in,shift_value,shift_out);

  input  [55:0] shift_in;
  input  [5:0] shift_value;
  output [55:0] shift_out;
  reg  [47:0] shift_out;

  
  always @(shift_value)
      begin
        case (shift_value)

          6'b000000: shift_out = shift_in;

          6'b000001: shift_out = shift_in<<1;

          6'b000010: shift_out = shift_in<<2;

          6'b000011: shift_out = shift_in<<3;

          6'b000100: shift_out = (2**4)*shift_in;

          6'b000101: shift_out = shift_in*(2**5);

          6'b000110: shift_out = shift_in*(2**6);

          6'b000111: shift_out = (2**7)*shift_in;

          6'b001000: shift_out = shift_in<<<8;

          6'b001001: shift_out = shift_in<<<9;

          6'b001010: shift_out = (2**10)*shift_in;

          6'b001011: shift_out = (2**11)*shift_in;

          6'b001100: shift_out = shift_in<<<12;

          6'b001101: shift_out = shift_in<<13;

          6'b001110: shift_out = shift_in<<<14;

          6'b001111: shift_out = shift_in<<15;

          6'b010000: shift_out = shift_in<<<16;

          6'b010001: shift_out = (2**17)*shift_in;

          6'b010010: shift_out = shift_in<<18;

          6'b010011: shift_out = shift_in<<<19;

          6'b010100: shift_out = shift_in*(2**20);

          6'b010101: shift_out = shift_in*(2**21);

          6'b010110: shift_out = (2**22)*shift_in;

          6'b010111: shift_out = shift_in<<23;

          6'b011000: shift_out = shift_in<<24;

          6'b011001: shift_out = (2**25)*shift_in;

          6'b011010: shift_out = shift_in<<<26;

          6'b011011: shift_out = (2**27)*shift_in;

          6'b011100: shift_out = shift_in<<28;

          6'b011101: shift_out = shift_in<<<29;

          6'b011110: shift_out = shift_in*(2**30);

          6'b011111: shift_out = (2**31)*shift_in;

          6'b100000: shift_out = shift_in<<<32;

          6'b100001: shift_out = shift_in<<<33;

          6'b100010: shift_out = shift_in<<34;

          6'b100011: shift_out = shift_in*(2**35);

          6'b100100: shift_out = shift_in*(2**36);

          6'b100101: shift_out = shift_in<<37;

          6'b100110: shift_out = shift_in*(2**38);

          6'b100111: shift_out = (2**39)*shift_in;

          6'b101000: shift_out = shift_in<<<40;

          6'b101001: shift_out = (2**41)*shift_in;

          6'b101010: shift_out = shift_in<<<42;

          6'b101011: shift_out = shift_in*(2**43);

          6'b101100: shift_out = shift_in<<44;

          6'b101101: shift_out = (2**45)*shift_in;

          6'b101110: shift_out = (2**46)*shift_in;

          6'b101111: shift_out = shift_in<<47;

          6'b110000: shift_out = shift_in<<<48;

          6'b110001: shift_out = (2**49)*shift_in;

          6'b110010: shift_out = shift_in<<<50;

          6'b110011: shift_out = shift_in<<<51;

          6'b110100: shift_out = (2**52)*shift_in;

          6'b110101: shift_out = (2**53)*shift_in;

          6'b110110: shift_out = shift_in<<54;

          6'b110111: shift_out = shift_in<<<55;

          6'b111000: shift_out = (2**56)*shift_in;

        endcase

      end
endmodule

