module priority_enc 
  (input [31:0] in, 
   output reg [31:0] out); 
   always @* 
     casex(in) 
       32'b1xxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : out <= 31; 
       32'b01xx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : out <= 30; 
       32'b0000_0000_0000_0000_0000_0000_0000_0001 : out <=  0; 
       32'b0000_0000_0000_0000_0000_0000_0000_0000 : out <= 32'hFFFF_FFFF; 
       default : out <= 32'hFFFF_FFFF; 
     endcase 
endmodule 