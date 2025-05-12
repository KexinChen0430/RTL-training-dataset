module LUT_Z#(parameter P = 32, parameter D = 5) ( 
input wire CLK, 
input wire EN_ROM1, 
input wire [D-1:0] ADRS, 
output reg [P-1:0] O_D 
);
always @(posedge CLK) 
      if (EN_ROM1) 
         case (ADRS) 
         endcase
        else
            O_D <= 32'b00000000000000000000000000000000; 
endmodule 