module bits_num(
    codenum_i,    
    bitsnum_o     
);
parameter MV_CODE_BITS = 5;
input  [`FMV_WIDTH     :0] codenum_i;
output [MV_CODE_BITS-1 :0] bitsnum_o;
reg    [MV_CODE_BITS-1 :0] bitsnum_o;
always @(codenum_i)
  casex(codenum_i)
    'b000_0000_0001: bitsnum_o = 1;
    'b000_0000_001x: bitsnum_o = 3;
    'b000_0000_01xx: bitsnum_o = 5;
    'b000_0000_1xxx: bitsnum_o = 7;
    'b000_0001_xxxx: bitsnum_o = 9;
    'b000_001x_xxxx: bitsnum_o = 11;
    'b000_01xx_xxxx: bitsnum_o = 13;
    'b000_1xxx_xxxx: bitsnum_o = 15;
    'b001_xxxx_xxxx: bitsnum_o = 17;
    'b01x_xxxx_xxxx: bitsnum_o = 19;
    'b1xx_xxxx_xxxx: bitsnum_o = 21;
    default:         bitsnum_o = 21;
  endcase
endmodule