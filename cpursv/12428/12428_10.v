
module DecoEscrituraRegistros(Address,Write,EnableStart,EnableRegister);

  input  Write;
  input  [8:0] Address;
  output [21:0] EnableRegister;
  output EnableStart;

  assign EnableStart = (Address == 9'h08C) ? 1'b1 : 1'b0;
  assign EnableRegister[0] = (Write & (Address == 9'h00C)) ? 1'b1 : 1'b0;
  assign EnableRegister[1] = (Write & (Address == 9'h010)) ? 1'b1 : 1'b0;
  assign EnableRegister[2] = (Write & (Address == 9'h014)) ? 1'b1 : 1'b0;
  assign EnableRegister[3] = ((Address == 9'h018) & Write) ? 1'b1 : 1'b0;
  assign EnableRegister[4] = (Write & (Address == 9'h01C)) ? 1'b1 : 1'b0;
  assign EnableRegister[5] = ((Address == 9'h020) & Write) ? 1'b1 : 1'b0;
  assign EnableRegister[6] = ((Address == 9'h024) & Write) ? 1'b1 : 1'b0;
  assign EnableRegister[7] = ((Address == 9'h028) & Write) ? 1'b1 : 1'b0;
  assign EnableRegister[8] = (Write & (Address == 9'h02C)) ? 1'b1 : 1'b0;
  assign EnableRegister[9] = (Write & (Address == 9'h030)) ? 1'b1 : 1'b0;
  assign EnableRegister[10] = (Write & (Address == 9'h034)) ? 1'b1 : 1'b0;
  assign EnableRegister[11] = (Write & (Address == 9'h038)) ? 1'b1 : 1'b0;
  assign EnableRegister[12] = (Write & (Address == 9'h03C)) ? 1'b1 : 1'b0;
  assign EnableRegister[13] = (Write & (Address == 9'h040)) ? 1'b1 : 1'b0;
  assign EnableRegister[14] = ((Address == 9'h044) & Write) ? 1'b1 : 1'b0;
  assign EnableRegister[15] = ((Address == 9'h048) & Write) ? 1'b1 : 1'b0;
  assign EnableRegister[16] = ((Address == 9'h04C) & Write) ? 1'b1 : 1'b0;
  assign EnableRegister[17] = ((Address == 9'h050) & Write) ? 1'b1 : 1'b0;
  assign EnableRegister[18] = (Write & (Address == 9'h054)) ? 1'b1 : 1'b0;
  assign EnableRegister[19] = ((Address == 9'h058) & Write) ? 1'b1 : 1'b0;
  assign EnableRegister[20] = (Write & (Address == 9'h05C)) ? 1'b1 : 1'b0;
  assign EnableRegister[21] = (Write & (Address == 9'h060)) ? 1'b1 : 1'b0;
endmodule

