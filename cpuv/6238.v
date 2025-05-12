module BRAM1BE(CLK, 
               EN,  
               WE,  
               ADDR, 
               DI,  
               DO   
              );
   parameter                      PIPELINED  = 0; 
   parameter                      ADDR_WIDTH = 1; 
   parameter                      DATA_WIDTH = 1; 
   parameter                      CHUNKSIZE  = 1; 
   parameter                      WE_WIDTH   = 1; 
   parameter                      MEMSIZE    = 1; 
   input                          CLK; 
   input                          EN;  
   input [WE_WIDTH-1:0]           WE;  
   input [ADDR_WIDTH-1:0]         ADDR; 
   input [DATA_WIDTH-1:0]         DI;  
   output [DATA_WIDTH-1:0]        DO;  
   reg [DATA_WIDTH-1:0]           RAM[0:MEMSIZE-1]; 
   reg [DATA_WIDTH-1:0]           DO_R; 
   reg [DATA_WIDTH-1:0]           DO_R2; 
   reg [DATA_WIDTH-1:0]           DATA; 
   wire [DATA_WIDTH-1:0]          DATAwr; 
   assign DATAwr = RAM[ADDR] ; 
`ifdef BSV_NO_INITIAL_BLOCKS
`else
   initial 
   begin : init_block
      integer   i; 
      for (i = 0; i < MEMSIZE; i = i + 1) begin 
         RAM[i] = { ((DATA_WIDTH+1)/2) { 2'b10 } }; 
      end
      DO_R  = { ((DATA_WIDTH+1)/2) { 2'b10 } }; 
      DO_R2 = { ((DATA_WIDTH+1)/2) { 2'b10 } }; 
   end
`endif 
`ifdef __ICARUS__
   reg [DATA_WIDTH-1:0] MASK, IMASK; 
   always @(WE or DI or DATAwr) begin : combo1 
      integer j; 
      MASK  = 0; 
      IMASK = 0; 
      for(j = WE_WIDTH-1; j >= 0; j = j - 1) begin 
         if (WE[j]) MASK = (MASK << 8) | { { DATA_WIDTH-CHUNKSIZE { 1'b0 } }, { CHUNKSIZE { 1'b1 } } }; 
         else       MASK = (MASK << 8); 
      end
      IMASK = ~MASK; 
      DATA = (DATAwr & IMASK) | (DI & MASK); 
   end
`else
   always @(WE or DI or DATAwr) begin : combo1 
      integer j; 
      for(j = 0; j < WE_WIDTH; j = j + 1) begin 
         if (WE[j]) DATA[j*CHUNKSIZE +: CHUNKSIZE] = DI[j*CHUNKSIZE +: CHUNKSIZE]; 
         else       DATA[j*CHUNKSIZE +: CHUNKSIZE] = DATAwr[j*CHUNKSIZE +: CHUNKSIZE]; 
      end
   end
`endif 
   always @(posedge CLK) begin 
      if (EN) begin 
         if (|WE) begin 
            RAM[ADDR] <= `BSV_ASSIGNMENT_DELAY DATA; 
            DO_R <= `BSV_ASSIGNMENT_DELAY DATA; 
         end
         else begin 
            DO_R <= `BSV_ASSIGNMENT_DELAY RAM[ADDR]; 
         end
      end
      DO_R2 <= `BSV_ASSIGNMENT_DELAY DO_R; 
   end
   assign DO = (PIPELINED) ? DO_R2 : DO_R; 
endmodule