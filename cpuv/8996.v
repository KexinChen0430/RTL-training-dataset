module uartrxsm_m
  # ( parameter HUNT = 2'b00, 
             GRCE = 2'b01, 
             ARMD = 2'b10, 
             RECV = 2'b11  
   )
   (input            clk,     
    input            rxce,    
    input            rxpin,   
    input            lastbit, 
    output           bytercvd,
    output reg [1:0] rxst     
    );
   reg [1:0]         nxt;     
`ifdef SIMULATION
   initial rxst = 0;          
`endif
   always @(lastbit or rxce or rxpin or rxst) begin
      casez ( {rxst,rxpin,lastbit,rxce} )
        {HUNT,3'b1??} : nxt = HUNT; 
        {HUNT,3'b0?0} : nxt = HUNT; 
        {HUNT,3'b0?1} : nxt = ARMD; 
        {ARMD,3'b??0} : nxt = ARMD; 
        {ARMD,3'b0?1} : nxt = RECV; 
        {ARMD,3'b1?1} : nxt = HUNT; 
        {RECV,3'b??0} : nxt = RECV; 
        {RECV,3'b?01} : nxt = RECV; 
        {RECV,3'b?11} : nxt = GRCE; 
        {GRCE,3'b??0} : nxt = GRCE; 
        {GRCE,3'b0?1} : nxt = HUNT; 
        {GRCE,3'b1?1} : nxt = HUNT; 
      endcase
   end
   always @(posedge clk)
     rxst <= nxt; 
   assign bytercvd = (rxst == GRCE) && rxpin && rxce; 
endmodule