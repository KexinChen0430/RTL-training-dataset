module Mapper68(input clk, input ce, input reset, 
                input [31:0] flags, 
                input [15:0] prg_ain, output [21:0] prg_aout, 
                input prg_read, prg_write, 
                input [7:0] prg_din, 
                output prg_allow, 
                input [13:0] chr_ain, output [21:0] chr_aout, 
                output chr_allow, 
                output vram_a10, 
                output vram_ce) { 
  reg [6:0] chr_bank_0, chr_bank_1, chr_bank_2, chr_bank_3; 
  reg [6:0] nametable_0, nametable_1; 
  reg [2:0] prg_bank; 
  reg use_chr_rom; 
  reg mirroring; 
  always @(posedge clk) if (reset) begin 
    chr_bank_0 <= 0; 
    chr_bank_1 <= 0;
    chr_bank_2 <= 0;
    chr_bank_3 <= 0;
    nametable_0 <= 0;
    nametable_1 <= 0;
    prg_bank <= 0;
    use_chr_rom <= 0;
    mirroring <= 0;
  end else if (ce) begin 
    if (prg_ain[15] && prg_write) begin 
      case(prg_ain[14:12]) 
      0: chr_bank_0  <= prg_din[6:0]; 
      1: chr_bank_1  <= prg_din[6:0]; 
      2: chr_bank_2  <= prg_din[6:0]; 
      3: chr_bank_3  <= prg_din[6:0]; 
      4: nametable_0 <= prg_din[6:0]; 
      5: nametable_1 <= prg_din[6:0]; 
      6: {use_chr_rom, mirroring} <= {prg_din[4], prg_din[0]};  
      7: prg_bank <= prg_din[2:0]; 
      endcase
    end
  end
  wire [2:0] prgout = (prg_ain[14] ? 3'b111 : prg_bank); 
  assign prg_aout = {5'b00_000, prgout, prg_ain[13:0]}; 
  assign prg_allow = prg_ain[15] && !prg_write; 
  reg [6:0] chrout; 
  always begin 
    casez(chr_ain[12:11]) 
    0: chrout = chr_bank_0; 
    1: chrout = chr_bank_1; 
    2: chrout = chr_bank_2; 
    3: chrout = chr_bank_3; 
    endcase
  end
  assign vram_a10 = mirroring ? chr_ain[11] : chr_ain[10]; 
  wire [6:0] nameout = (vram_a10 == 0) ? nametable_0 : nametable_1; 
  assign chr_allow = flags[15]; 
  assign chr_aout = (chr_ain[13] == 0) ? {4'b10_00, chrout, chr_ain[10:0]} : {5'b10_001, nameout, chr_ain[9:0]}; 
  assign vram_ce = chr_ain[13] && !use_chr_rom; 
endmodule