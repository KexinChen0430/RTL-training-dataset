
module address(input  CLK,
               input  [15:0] featurebits,
               input  [2:0] MAPPER,
               input  [23:0] SNES_ADDR,
               input  [7:0] SNES_PA,
               output [23:0] ROM_ADDR,
               output ROM_HIT,
               output IS_SAVERAM,
               output IS_ROM,
               output IS_WRITABLE,
               input  [23:0] SAVERAM_MASK,
               input  [23:0] ROM_MASK,
               output msu_enable,
               output cx4_enable,
               output cx4_vect_enable,
               output r213f_enable,
               output r2100_hit,
               output snescmd_enable,
               output nmicmd_enable,
               output return_vector_enable,
               output branch1_enable,
               output branch2_enable);

  parameter [2:0]  FEAT_MSU1 = 3, FEAT_213F = 4, FEAT_2100 = 6;
  wire [23:0] SRAM_SNES_ADDR;

  assign IS_ROM = SNES_ADDR[22] | (!SNES_ADDR[22] & SNES_ADDR[15]);
  assign IS_SAVERAM = |((((~SNES_ADDR[19] & ({SNES_ADDR[19:16],SNES_ADDR[14:0]} | SAVERAM_MASK)) | (~SNES_ADDR[19] & (24'hE00000 | (({SNES_ADDR[19:16],SNES_ADDR[14:0]} | (24'hE00000 & SAVERAM_MASK)) & (24'hE00000 | SAVERAM_MASK))))) & ((&SNES_ADDR[22:20] & (SAVERAM_MASK | (24'hE00000 | {SNES_ADDR[19:16],SNES_ADDR[14:0]}))) & (SAVERAM_MASK & ~SNES_ADDR[15]))) & ~SNES_ADDR[23]);
  assign SRAM_SNES_ADDR = IS_SAVERAM ? (24'hE00000 | (({SNES_ADDR[19:16],SNES_ADDR[14:0]} | (24'hE00000 & SAVERAM_MASK)) & (24'hE00000 | SAVERAM_MASK))) : (ROM_MASK & {2'b00,SNES_ADDR[22:16],SNES_ADDR[14:0]});
  assign ROM_ADDR = SRAM_SNES_ADDR;
  assign IS_WRITABLE = IS_SAVERAM;
  assign ROM_HIT = IS_WRITABLE | IS_ROM;
  wire 
       msu_enable_w = featurebits[FEAT_MSU1] & !SNES_ADDR[22] && 
((SNES_ADDR[15:0] & 16'hfff8) == 16'h2000);

  assign msu_enable = msu_enable_w;
  wire 
       cx4_enable_w = (SNES_ADDR[15:13] == 3'b011) && !SNES_ADDR[22];

  assign cx4_enable = cx4_enable_w;
  assign cx4_vect_enable = &SNES_ADDR[15:5];
  assign r213f_enable = (SNES_PA == 8'h3f) & featurebits[FEAT_213F];
  assign r2100_hit = SNES_PA == 8'h00;
  assign snescmd_enable = {SNES_ADDR[22],SNES_ADDR[15:9]} == 8'b0_0010101;
  assign nmicmd_enable = SNES_ADDR == 24'h002BF2;
  assign return_vector_enable = SNES_ADDR == 24'h002A5A;
  assign branch1_enable = SNES_ADDR == 24'h002A13;
  assign branch2_enable = SNES_ADDR == 24'h002A4D;
endmodule

