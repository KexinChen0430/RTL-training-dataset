module Mapper15(input clk, input ce, input reset,
                input [31:0] flags,
                input [15:0] prg_ain, output [21:0] prg_aout,
                input prg_read, prg_write,                   
                input [7:0] prg_din,
                output prg_allow,                            
                input [13:0] chr_ain, output [21:0] chr_aout,
                output chr_allow,                            
                output vram_a10,                             
                output vram_ce);                             
reg [1:0] prg_rom_bank_mode;
reg prg_rom_bank_lowbit;
reg mirroring;
reg [5:0] prg_rom_bank;
always @(posedge clk) if (reset) begin
    prg_rom_bank_mode <= 0;
    prg_rom_bank_lowbit <= 0;
    mirroring <= 0;
    prg_rom_bank <= 0;
end else if (ce) begin
    if (prg_ain[15] && prg_write)
      {prg_rom_bank_mode, prg_rom_bank_lowbit, mirroring, prg_rom_bank} <= {prg_ain[1:0], prg_din[7:0]};
end
reg [6:0] prg_bank;
always @* begin
    casez({prg_rom_bank_mode, prg_ain[14]})
    3'b00_0: prg_bank = {prg_rom_bank, prg_ain[13]};
    3'b00_1: prg_bank = {prg_rom_bank | 6'b1, prg_ain[13]};
    3'b01_0: prg_bank = {prg_rom_bank, prg_ain[13]};
    3'b01_1: prg_bank = {6'b111111, prg_ain[13]};
    3'b10_?: prg_bank = {prg_rom_bank, prg_rom_bank_lowbit};
    3'b11_?: prg_bank = {prg_rom_bank, prg_ain[13]};
    endcase
end
assign prg_aout = {2'b00, prg_bank, prg_ain[12:0]};
assign prg_allow = prg_ain[15] && !prg_write;
assign chr_allow = flags[15]; 
assign chr_aout = {9'b10_0000_000, chr_ain[12:0]};
assign vram_ce = chr_ain[13];
assign vram_a10 = mirroring ? chr_ain[11] : chr_ain[10];
endmodule