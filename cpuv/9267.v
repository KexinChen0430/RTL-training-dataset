module BRAM2(CLKA, 
             ENA,  
             WEA,  
             ADDRA,
             DIA,  
             DOA,  
             CLKB, 
             ENB,  
             WEB,  
             ADDRB,
             DIB,  
             DOB   
             );
   parameter                      PIPELINED  = 0; 
   parameter                      ADDR_WIDTH = 1; 
   parameter                      DATA_WIDTH = 1; 
   parameter                      MEMSIZE    = 1; 
   input                          CLKA; 
   input                          ENA;  
   input                          WEA;  
   input [ADDR_WIDTH-1:0]         ADDRA; 
   input [DATA_WIDTH-1:0]         DIA; 
   output [DATA_WIDTH-1:0]        DOA; 
   input                          CLKB; 
   input                          ENB;  
   input                          WEB;  
   input [ADDR_WIDTH-1:0]         ADDRB; 
   input [DATA_WIDTH-1:0]         DIB; 
   output [DATA_WIDTH-1:0]        DOB; 
   reg [DATA_WIDTH-1:0]           RAM[0:MEMSIZE-1]  ; 
   reg [ADDR_WIDTH-1:0]           ADDRA_R; 
   reg [ADDR_WIDTH-1:0]           ADDRB_R; 
   reg [DATA_WIDTH-1:0]           DOA_R; 
   reg [DATA_WIDTH-1:0]           DOB_R; 
   wire [DATA_WIDTH-1:0] 	  DOA_noreg; 
   wire [DATA_WIDTH-1:0] 	  DOB_noreg; 
   wire [ADDR_WIDTH-1:0] 	  ADDRA_muxed; 
   wire [ADDR_WIDTH-1:0] 	  ADDRB_muxed; 
`ifdef BSV_NO_INITIAL_BLOCKS
`else
   integer                        i; 
   initial
   begin : init_block
      for (i = 0; i < MEMSIZE; i = i + 1) begin
         RAM[i] = { ((DATA_WIDTH+1)/2) { 2'b10 } }; 
      end
      ADDRA_R = { ((ADDR_WIDTH+1)/2) { 2'b10 } }; 
      ADDRB_R = { ((ADDR_WIDTH+1)/2) { 2'b10 } }; 
      DOA_R = { ((DATA_WIDTH+1)/2) { 2'b10 } }; 
      DOB_R = { ((DATA_WIDTH+1)/2) { 2'b10 } }; 
   end
`endif 
   always @(posedge CLKA) begin
      ADDRA_R <= `BSV_ASSIGNMENT_DELAY ADDRA_muxed; 
      if (ENA) begin
         if (WEA)
           RAM[ADDRA_muxed] <= `BSV_ASSIGNMENT_DELAY DIA; 
      end
   end
   always @(posedge CLKB) begin
      ADDRB_R <= `BSV_ASSIGNMENT_DELAY ADDRB_muxed; 
      if (ENB) begin
         if (WEB)
           RAM[ADDRB_muxed] <= `BSV_ASSIGNMENT_DELAY DIB; 
      end
   end
   assign ADDRA_muxed = (ENA) ? ADDRA : ADDRA_R; 
   assign ADDRB_muxed = (ENB) ? ADDRB : ADDRB_R; 
   assign DOA_noreg = RAM[ADDRA_R]; 
   assign DOB_noreg = RAM[ADDRB_R]; 
   always @(posedge CLKA)
      DOA_R <= DOA_noreg; 
   always @(posedge CLKB)
      DOB_R <= DOB_noreg; 
   assign DOA = (PIPELINED) ? DOA_R : DOA_noreg; 
   assign DOB = (PIPELINED) ? DOB_R : DOB_noreg; 
endmodule