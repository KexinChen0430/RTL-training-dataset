module FIFO10(CLK,  
              RST,  
              ENQ,  
              FULL_N,  
              DEQ,  
              EMPTY_N,  
              CLR  
              );
   parameter guarded = 1;  
   input                  CLK;  
   input                  RST;  
   input                  ENQ;  
   input                  DEQ;  
   input                  CLR ;  
   output                 FULL_N;  
   output                 EMPTY_N;  
   reg                    empty_reg ;  
   assign                 EMPTY_N = empty_reg ;  
`ifdef BSV_NO_INITIAL_BLOCKS
`else 
   initial  
     begin
        empty_reg = 1'b0;  
     end 
`endif 
   assign FULL_N = !empty_reg;  
   always@(posedge CLK )  
     begin
        if (RST == `BSV_RESET_VALUE)  
          begin
             empty_reg <= `BSV_ASSIGNMENT_DELAY 1'b0;  
          end 
        else  
           begin
              if (CLR)  
                begin
                   empty_reg <= `BSV_ASSIGNMENT_DELAY 1'b0;  
                end
              else if (ENQ)  
                begin
                   empty_reg <= `BSV_ASSIGNMENT_DELAY 1'b1;  
                end
              else if (DEQ)  
                begin
                   empty_reg <= `BSV_ASSIGNMENT_DELAY 1'b0;  
                end 
           end 
     end 
   always@(posedge CLK)  
     begin: error_checks  
        reg deqerror, enqerror ;  
        deqerror =  0;  
        enqerror = 0;  
        if (RST == ! `BSV_RESET_VALUE)  
           begin
              if ( ! empty_reg && DEQ )  
                begin
                   deqerror = 1 ;  
                   $display( "Warning: FIFO10: %m -- Dequeuing from empty fifo" ) ;  
                end
              if ( ! FULL_N && ENQ && (!DEQ || guarded) )  
                begin
                   enqerror =  1 ;  
                   $display( "Warning: FIFO10: %m -- Enqueuing to a full fifo" ) ;  
                end
           end 
     end
endmodule