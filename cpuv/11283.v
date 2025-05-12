module BRAM1(CLK,
             EN,
             WE,
             ADDR,
             DI,
             DO
             );
   parameter                      PIPELINED  = 0; 
   parameter                      ADDR_WIDTH = 1; 
   parameter                      DATA_WIDTH = 1; 
   parameter                      MEMSIZE    = 1; 
   input                          CLK;       
   input                          EN;        
   input                          WE;        
   input [ADDR_WIDTH-1:0]         ADDR;      
   input [DATA_WIDTH-1:0]         DI;        
   output [DATA_WIDTH-1:0]        DO;        
   reg [DATA_WIDTH-1:0]           RAM[0:MEMSIZE-1]; 
   reg [ADDR_WIDTH-1:0]           ADDR_R;    
   reg [DATA_WIDTH-1:0]           DO_R;      
`ifdef BSV_NO_INITIAL_BLOCKS
`else
   integer                        i;         
   initial
   begin : init_block
      for (i = 0; i < MEMSIZE; i = i + 1) begin
         RAM[i] = { ((DATA_WIDTH+1)/2) { 2'b10 } }; 
      end
      ADDR_R = { ((ADDR_WIDTH+1)/2) { 2'b10 } }; 
      DO_R = { ((DATA_WIDTH+1)/2) { 2'b10 } }; 
   end
`endif 
   always @(posedge CLK) begin
      if (EN) begin 
         if (WE)
           RAM[ADDR] <= `BSV_ASSIGNMENT_DELAY DI; 
         ADDR_R    <= `BSV_ASSIGNMENT_DELAY ADDR; 
      end
      DO_R      <= `BSV_ASSIGNMENT_DELAY RAM[ADDR_R]; 
   end
   assign DO = (PIPELINED) ? DO_R : RAM[ADDR_R];
endmodule 