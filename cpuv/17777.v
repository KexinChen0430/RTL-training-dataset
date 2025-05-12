module PositiveReset (
  IN_RST,
  CLK,
  OUT_RST
  );
   parameter          RSTDELAY = 1  ; 
   input              CLK ; 
   input              IN_RST ; 
   output             OUT_RST ; 
   (* ASYNC_REG = "true" *) 
   reg                reset_meta ; 
   reg [RSTDELAY:1]   reset_hold ; 
   wire [RSTDELAY+1:0] next_reset = {reset_hold, reset_meta, 1'b0} ; 
   assign  OUT_RST = reset_hold[RSTDELAY] ; 
   always @( posedge CLK )      
     begin
        if (IN_RST == `BSV_RESET_VALUE) 
           begin
              reset_meta <= 1; 
           end
        else
          begin
              reset_meta <= 0; 
          end
        if (reset_meta == 1) 
          begin
              reset_hold <= `BSV_ASSIGNMENT_DELAY -1 ; 
          end
        else
          begin
              reset_hold <= `BSV_ASSIGNMENT_DELAY next_reset[RSTDELAY:1]; 
          end
     end 
`ifdef BSV_NO_INITIAL_BLOCKS 
`else 
   initial 
     begin
        #0 ; 
        reset_hold = 0 ;
     end
`endif 
endmodule 