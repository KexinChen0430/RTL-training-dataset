module ram_1clk_1w_1r
    #(
      parameter C_RAM_WIDTH = 32, 
      parameter C_RAM_DEPTH = 1024 
      )
    (
     input                           CLK,   
     input [clog2s(C_RAM_DEPTH)-1:0] ADDRA, 
     input                           WEA,   
     input [clog2s(C_RAM_DEPTH)-1:0] ADDRB, 
     input [C_RAM_WIDTH-1:0]         DINA,  
     output [C_RAM_WIDTH-1:0]        DOUTB  
     );
`include "functions.vh"
localparam C_RAM_ADDR_BITS = clog2s(C_RAM_DEPTH);
reg [C_RAM_WIDTH-1:0] rRAM [C_RAM_DEPTH-1:0];
reg [C_RAM_WIDTH-1:0] rDout;
assign DOUTB = rDout;
always @(posedge CLK) begin
    if (WEA)
        rRAM[ADDRA] <= #1 DINA; 
    rDout <= #1 rRAM[ADDRB]; 
end
endmodule