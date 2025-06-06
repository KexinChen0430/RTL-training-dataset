
module shift(Inst,Enable,RD2_input,ALUSrc2_output);

  input  [7:0] Inst;
  input  Enable;
  input  [31:0] RD2_input;
  output [31:0] ALUSrc2_output;
  wire [4:0] shamt5;

  assign shamt5[4:0] = (Inst[0] == 0) ? Inst[7:3] : 5'b00000;
  wire [1:0] sh;

  assign sh[1:0] = Inst[1<<1:1];
  wire [31:0] internal_output;

  assign internal_output = (sh[1] == 1) ? ((sh[0] == 1) ? (((1<<1**(0-shamt5))<<<32*RD2_input) | RD2_input>>shamt5) : ({32{1'b1}}<<(0-shamt5)<<32 | RD2_input>>shamt5)) : 
                           (sh[0] == 1) ? RD2_input>>shamt5 : (1<<<shamt5*RD2_input);
  assign ALUSrc2_output = (Enable == 1) ? internal_output : RD2_input;
endmodule

