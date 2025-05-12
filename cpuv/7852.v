module SizedFIFOL0(CLK, RST, ENQ, FULL_N, DEQ, EMPTY_N, CLR); 
   parameter p1depth = 2; 
   parameter p2cntr_width = 2; 
   localparam truedepth = (p1depth >= 2) ? p1depth : 2; 
   input     CLK; 
   input     RST; 
   input     CLR; 
   input     ENQ; 
   input     DEQ; 
   output    FULL_N; 
   output    EMPTY_N; 
   reg       not_full; 
   reg       not_empty; 
   reg [p2cntr_width-1 : 0] count; 
   assign                 EMPTY_N = not_empty; 
   assign                 FULL_N = not_full || DEQ; 
`ifdef BSV_NO_INITIAL_BLOCKS 
`else 
   initial 
     begin
        count      = 0 ; 
        not_empty  = 1'b0; 
        not_full   = 1'b1; 
     end 
`endif 
   always @(posedge CLK `BSV_ARESET_EDGE_META) 
     begin
        if (RST == `BSV_RESET_VALUE) 
        begin
           count <= `BSV_ASSIGNMENT_DELAY 0 ; 
           not_empty <= `BSV_ASSIGNMENT_DELAY 1'b0; 
           not_full <= `BSV_ASSIGNMENT_DELAY 1'b1; 
        end 
        else
          begin
             if (CLR) 
               begin
                  count <= `BSV_ASSIGNMENT_DELAY 0 ; 
                  not_empty <= `BSV_ASSIGNMENT_DELAY 1'b0; 
                  not_full <= `BSV_ASSIGNMENT_DELAY 1'b1; 
               end 
             else begin
                if (DEQ && ! ENQ && not_empty ) 
                  begin
                     not_full <= `BSV_ASSIGNMENT_DELAY 1'b1; 
                     not_empty <= `BSV_ASSIGNMENT_DELAY  count != 'b01  ; 
                     count <= `BSV_ASSIGNMENT_DELAY count - 1'b1 ; 
                  end 
                else if (ENQ && ! DEQ && not_full ) 
                  begin
                     not_empty <= `BSV_ASSIGNMENT_DELAY 1'b1; 
                     not_full <= `BSV_ASSIGNMENT_DELAY count != (truedepth - 1) ; 
                     count <= `BSV_ASSIGNMENT_DELAY count + 1'b1 ; 
                  end 
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
              if ( ! EMPTY_N && DEQ ) 
                begin
                   deqerror = 1 ; 
                   $display( "Warning: SizedFIFOL0: %m -- Dequeuing from empty fifo" ) ; 
                end
              if ( ! FULL_N && ENQ ) 
                begin
                   enqerror =  1 ; 
                   $display( "Warning: SizedFIFOL0: %m -- Enqueuing to a full fifo" ) ; 
                end
           end 
     end 
endmodule 