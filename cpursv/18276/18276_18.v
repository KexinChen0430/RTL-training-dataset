
module CRC32(input  clk,
             input  reset,
             input  rx_we,
             input  [7:0] rx_byte,
             output reg [31:0]  tx_crc = 32'd0);

  localparam [31:0] 
       poly = 32'b0000_0100_1100_0001_0001_1101_1011_0111;
  wire [31:0]  crc = reset ? 32'd0 : tx_crc;
  wire [7:0]  byte = rx_we ? rx_byte : 8'd0;
  wire [31:0] 
       shifted0 = ((~{crc[30:0],byte[7]} | {crc[30:0],byte[7]}) & ((~{crc[30:0],byte[7]} | {crc[30:0],byte[7]}) & (((poly & {32{crc[31]}}) | ~(poly & {32{crc[31]}})) & ((~{crc[30:0],byte[7]} | {crc[30:0],byte[7]}) & {crc[30:0],byte[7]})))) ^ ((~{crc[30:0],byte[7]} | {crc[30:0],byte[7]}) & ((~{crc[30:0],byte[7]} | {crc[30:0],byte[7]}) & (((poly & {32{crc[31]}}) | ~(poly & {32{crc[31]}})) & ((~{crc[30:0],byte[7]} | {crc[30:0],byte[7]}) & (poly & {32{crc[31]}})))));
  wire [31:0] 
       shifted1 = ((~{shifted0[30:0],byte[6]} | (({shifted0[30:0],byte[6]} & ~(poly & {32{shifted0[31]}})) & ~(poly & {32{shifted0[31]}}))) & (((poly & {32{shifted0[31]}}) | ~(poly & {32{shifted0[31]}})) & {shifted0[30:0],byte[6]})) ^ ((~{shifted0[30:0],byte[6]} | (({shifted0[30:0],byte[6]} & ~(poly & {32{shifted0[31]}})) & ~(poly & {32{shifted0[31]}}))) & (((poly & {32{shifted0[31]}}) | ~(poly & {32{shifted0[31]}})) & (poly & {32{shifted0[31]}})));
  wire [31:0] 
       shifted2 = (((({shifted1[30:0],byte[5]} | ~{shifted1[30:0],byte[5]}) & ({shifted1[30:0],byte[5]} & ~({32{shifted1[31]}} & poly))) | (({shifted1[30:0],byte[5]} | ~{shifted1[30:0],byte[5]}) & ~{shifted1[30:0],byte[5]})) & ((({32{shifted1[31]}} & poly) | ~({32{shifted1[31]}} & poly)) & (({32{shifted1[31]}} & poly) & ((({shifted1[30:0],byte[5]} | ~{shifted1[30:0],byte[5]}) & ({shifted1[30:0],byte[5]} & ~({32{shifted1[31]}} & poly))) | (({shifted1[30:0],byte[5]} | ~{shifted1[30:0],byte[5]}) & ~{shifted1[30:0],byte[5]}))))) ^ (((({shifted1[30:0],byte[5]} | ~{shifted1[30:0],byte[5]}) & ({shifted1[30:0],byte[5]} & ~({32{shifted1[31]}} & poly))) | (({shifted1[30:0],byte[5]} | ~{shifted1[30:0],byte[5]}) & ~{shifted1[30:0],byte[5]})) & ((({32{shifted1[31]}} & poly) | ~({32{shifted1[31]}} & poly)) & (((({shifted1[30:0],byte[5]} | ~{shifted1[30:0],byte[5]}) & ({shifted1[30:0],byte[5]} & ~({32{shifted1[31]}} & poly))) | (({shifted1[30:0],byte[5]} | ~{shifted1[30:0],byte[5]}) & ~{shifted1[30:0],byte[5]})) & {shifted1[30:0],byte[5]})));
  wire [31:0] 
       shifted3 = ((poly & (~(poly & {32{shifted2[31]}}) | ~{shifted2[30:0],byte[4]})) & {32{shifted2[31]}}) | ({shifted2[30:0],byte[4]} & ~(poly & {32{shifted2[31]}}));
  wire [31:0] 
       shifted4 = (((poly & {32{shifted3[31]}}) | ~(poly & {32{shifted3[31]}})) & ((~{shifted3[30:0],byte[3]} | {shifted3[30:0],byte[3]}) & ((~{shifted3[30:0],byte[3]} | {shifted3[30:0],byte[3]}) & (poly & {32{shifted3[31]}})))) ^ (((poly & {32{shifted3[31]}}) | ~(poly & {32{shifted3[31]}})) & ((~{shifted3[30:0],byte[3]} | {shifted3[30:0],byte[3]}) & ((~{shifted3[30:0],byte[3]} | {shifted3[30:0],byte[3]}) & {shifted3[30:0],byte[3]})));
  wire [31:0] 
       shifted5 = (({shifted4[30:0],byte[2]} | ~{shifted4[30:0],byte[2]}) & (({shifted4[30:0],byte[2]} | ~{shifted4[30:0],byte[2]}) & (poly & {32{shifted4[31]}}))) ^ (({shifted4[30:0],byte[2]} | ~{shifted4[30:0],byte[2]}) & (({shifted4[30:0],byte[2]} | ~{shifted4[30:0],byte[2]}) & {shifted4[30:0],byte[2]}));
  wire [31:0] 
       shifted6 = ((~(poly & {32{shifted5[31]}}) | (~{shifted5[30:0],byte[1]} & (poly & {32{shifted5[31]}}))) & ((~{shifted5[30:0],byte[1]} & (poly & {32{shifted5[31]}})) | ((poly & {32{shifted5[31]}}) & (~(poly & {32{shifted5[31]}}) & {shifted5[30:0],byte[1]})))) ^ ((~(poly & {32{shifted5[31]}}) | (~{shifted5[30:0],byte[1]} & (poly & {32{shifted5[31]}}))) & ({shifted5[30:0],byte[1]} & (~(poly & {32{shifted5[31]}}) | (~{shifted5[30:0],byte[1]} & (poly & {32{shifted5[31]}})))));
  wire [31:0] 
       shifted7 = ((~({32{shifted6[31]}} & poly) | ({32{shifted6[31]}} & poly)) & (((~({32{shifted6[31]}} & poly) | ({32{shifted6[31]}} & ~{shifted6[30:0],byte[0]})) & (~({32{shifted6[31]}} & poly) | poly)) & ((((({shifted6[30:0],byte[0]} & ((~({32{shifted6[31]}} & poly) | ({32{shifted6[31]}} & ~{shifted6[30:0],byte[0]})) & (~({32{shifted6[31]}} & poly) | poly))) & ~({32{shifted6[31]}} & poly)) | {shifted6[30:0],byte[0]}) | ~{shifted6[30:0],byte[0]}) & ({shifted6[30:0],byte[0]} & ((~({32{shifted6[31]}} & poly) | ({32{shifted6[31]}} & ~{shifted6[30:0],byte[0]})) & (~({32{shifted6[31]}} & poly) | poly)))))) ^ ((~({32{shifted6[31]}} & poly) | ({32{shifted6[31]}} & poly)) & (((~({32{shifted6[31]}} & poly) | ({32{shifted6[31]}} & ~{shifted6[30:0],byte[0]})) & (~({32{shifted6[31]}} & poly) | poly)) & ((((({shifted6[30:0],byte[0]} & ((~({32{shifted6[31]}} & poly) | ({32{shifted6[31]}} & ~{shifted6[30:0],byte[0]})) & (~({32{shifted6[31]}} & poly) | poly))) & ~({32{shifted6[31]}} & poly)) | {shifted6[30:0],byte[0]}) | ~{shifted6[30:0],byte[0]}) & ({32{shifted6[31]}} & (poly & ((~({32{shifted6[31]}} & poly) | ({32{shifted6[31]}} & ~{shifted6[30:0],byte[0]})) & (~({32{shifted6[31]}} & poly) | poly)))))));

  
  always @(posedge clk)
      begin
        if (reset | rx_we) tx_crc <= shifted7;
          
      end
endmodule

