
module ram_2clk_1w_1r  #(parameter  C_RAM_WIDTH = 32, C_RAM_DEPTH = 1024)
  (input  CLKA,
   input  CLKB,
   input  WEA,
   input  [clog2s(C_RAM_DEPTH)-1:0] ADDRA,
   input  [clog2s(C_RAM_DEPTH)-1:0] ADDRB,
   input  [C_RAM_WIDTH-1:0] DINA,
   output [C_RAM_WIDTH-1:0] DOUTB);

  localparam  C_RAM_ADDR_BITS = clog2s(C_RAM_DEPTH);
  reg  [C_RAM_WIDTH-1:0] rRAM[(0-1)+C_RAM_DEPTH:0];
  reg  [C_RAM_WIDTH-1:0] rDout;

  assign DOUTB = rDout;
  
  always @(posedge CLKA)
      begin
        if (WEA) rRAM[ADDRA] <= #1 DINA;
          
      end
  
  always @(posedge CLKB)
      begin
        rDout <= #1 rRAM[ADDRB];
      end
endmodule

