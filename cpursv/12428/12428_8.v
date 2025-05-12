
module DecoEscrituraRegistros(Address,Write,EnableStart,EnableRegister);

  input  Write;
  input  [8:0] Address;
  output [21:0] EnableRegister;
  output EnableStart;

  assign EnableStart = (Address == 9'h08C) ? 1'b1 : 1'b0;
  assign EnableRegister[0] = (Write & (Address == 9'h00C)) ? 1'b1 : 1'b0;
  assign EnableRegister[1] = (Write & (Address == 9'h010)) ? 1'b1 : 1'b0;
  assign EnableRegister[2] = ((Address == 9'h014) & Write) ? 1'b1 : 1'b0;
  assign EnableRegister[3] = ((Address == 9'h018) & Write) ? 1'b1 : 1'b0;
  assign EnableRegister[4] = (Write & (Address == 9'h01C)) ? 1'b1 : 1'b0;
  assign EnableRegister[5] = ((Address == 9'h020) & Write) ? 1'b1 : 1'b0;
  assign EnableRegister[6] = (Write & (Address == 9'h024)) ? 1'b1 : 1'b0;
  assign EnableRegister[7] = ((Address == 9'h028) & Write) ? 1'b1 : 1'b0;
  assign EnableRegister[8] = ((Address == 9'h02C) & Write) ? 1'b1 : 1'b0;
  assign EnableRegister[9] = ((Address == 9'h030) & Write) ? 1'b1 : 1'b0;
  assign EnableRegister[10] = (Write & (Address == 9'h034)) ? 1'b1 : 1'b0;
  assign EnableRegister[11] = ((Address == 9'h038) & Write) ? 1'b1 : 1'b0;
  assign EnableRegister[12] = ((Address == 9'h03C) & Write) ? 1'b1 : 1'b0;
  assign EnableRegister[13] = ((Address == 9'h040) & Write) ? 1'b1 : 1'b0;
  assign EnableRegister[14] = (Write & (Address == 9'h044)) ? 1'b1 : 1'b0;
  assign EnableRegister[15] = ((Address == 9'h048) & Write) ? 1'b1 : 1'b0;
  assign EnableRegister[16] = (Write & (Address == 9'h04C)) ? 1'b1 : 1'b0;
  assign EnableRegister[17] = (Write & (Address == 9'h050)) ? 1'b1 : 1'b0;
  assign EnableRegister[18] = ((Address == 9'h054) & Write) ? 1'b1 : 1'b0;
  assign EnableRegister[19] = ((Address == 9'h058) & Write) ? 1'b1 : 1'b0;
  assign EnableRegister[20] = (Write & (Address == 9'h05C)) ? 1'b1 : 1'b0;
  assign EnableRegister[21] = ((Address == 9'h060) & Write) ? 1'b1 : 1'b0;
endmodule

