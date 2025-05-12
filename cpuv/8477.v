module LUT_SHIFT #(parameter P = 5) ( 
input wire CLK, 
input wire EN_ROM1, 
input wire [4:0] ADRS, 
output reg [P-1:0] O_D 
);
always @(posedge CLK) 
      if (EN_ROM1) 
         case (ADRS) 
            5'b00000: O_D <= 5'b00001; 
            5'b00001: O_D <= 5'b00010; 
            5'b00010: O_D <= 5'b00011; 
            5'b00011: O_D <= 5'b00100; 
            5'b00100: O_D <= 5'b00100; 
            5'b00101: O_D <= 5'b00101; 
            default:  O_D <= 5'b00000; 
         endcase
endmodule