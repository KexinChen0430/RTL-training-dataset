module clz(
  input wire [7:0] data_i, 
  output wire [6:0] out    
);
  reg [2:0]  clz_byte0; 
  reg [2:0]  clz_byte1; 
  reg [2:0]  clz_byte2; 
  reg [2:0]  clz_byte3; 
  always @*
    case (data_i)
      `def_1xxx_xxxx : clz_byte0 = 3'b000; 
      `def_01xx_xxxx : clz_byte0 = 3'b001; 
      `def_001x_xxxx : clz_byte0 = 3'b010; 
      `def_0001_xxxx : clz_byte0 = 3'b011; 
      `def_0000_1xxx : clz_byte0 = 3'b100; 
      `def_0000_01xx : clz_byte0 = 3'b101; 
      `def_0000_001x : clz_byte0 = 3'b110; 
      8'b0000_0001   : clz_byte0 = 3'b111; 
      8'b0000_0000   : clz_byte0 = 3'b111; 
      default        : clz_byte0 = 3'bxxx; 
    endcase
  always @*
    case (data_i)
      `def_1xxx_xxxx : clz_byte1 = 3'b000;
      `def_01xx_xxxx : clz_byte1 = 3'b001;
      `def_001x_xxxx : clz_byte1 = 3'b010;
      `def_0001_xxxx : clz_byte1 = 3'b011;
      `def_0000_1xxx : clz_byte1 = 3'b100;
      `def_0000_01xx : clz_byte1 = 3'b101;
      `def_0000_001x : clz_byte1 = 3'b110;
      8'b0000_0001   : clz_byte1 = 3'b111;
      8'b0000_0000   : clz_byte1 = 3'b111;
      default        : clz_byte1 = 3'bxxx;
    endcase
  always @*
    case (data_i)
      `def_1xxx_xxxx : clz_byte2 = 3'b000;
      `def_01xx_xxxx : clz_byte2 = 3'b001;
      `def_001x_xxxx : clz_byte2 = 3'b010;
      `def_0001_xxxx : clz_byte2 = 3'b011;
      `def_0000_1xxx : clz_byte2 = 3'b100;
      `def_0000_01xx : clz_byte2 = 3'b101;
      `def_0000_001x : clz_byte2 = 3'b110;
      8'b0000_0001   : clz_byte2 = 3'b111;
      8'b0000_0000   : clz_byte2 = 3'b111;
      default        : clz_byte2 = 3'bxxx;
    endcase
  always @*
    case (data_i)
      `def_1xxx_xxxx : clz_byte3 = 3'b000;
      `def_01xx_xxxx : clz_byte3 = 3'b001;
      `def_001x_xxxx : clz_byte3 = 3'b010;
      `def_0001_xxxx : clz_byte3 = 3'b011;
      `def_0000_1xxx : clz_byte3 = 3'b100;
      `def_0000_01xx : clz_byte3 = 3'b101;
      `def_0000_001x : clz_byte3 = 3'b110;
      8'b0000_0001   : clz_byte3 = 3'b111;
      8'b0000_0000   : clz_byte3 = 3'b111;
      default        : clz_byte3 = 3'bxxx;
    endcase
  assign out = {4'b0000, clz_byte1};
endmodule 