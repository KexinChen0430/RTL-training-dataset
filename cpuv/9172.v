module FIFO1(CLK, 
             RST, 
             D_IN, 
             ENQ, 
             FULL_N, 
             D_OUT, 
             DEQ, 
             EMPTY_N, 
             CLR 
             );
   parameter width = 1; 
   parameter guarded = 1; 
   input                  CLK; 
   input                  RST; 
   input [width - 1 : 0]  D_IN; 
   input                  ENQ; 
   input                  DEQ; 
   input                  CLR ; 
   output                 FULL_N; 
   output [width - 1 : 0] D_OUT; 
   output                 EMPTY_N; 
   reg [width - 1 : 0]    D_OUT; 
   reg                    empty_reg ; 
   assign                 EMPTY_N = empty_reg ; 
`ifdef BSV_NO_INITIAL_BLOCKS
`else 
   initial 
     begin
        D_OUT   = {((width + 1)/2) {2'b10}} ; 
        empty_reg = 1'b0 ; 
     end 
`endif 
   assign FULL_N = !empty_reg; 
   always@(posedge CLK `BSV_ARESET_EDGE_META) 
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
   always@(posedge CLK `BSV_ARESET_EDGE_HEAD) 
     begin
`ifdef BSV_RESET_FIFO_HEAD
        if (RST == `BSV_RESET_VALUE) 
          begin
             D_OUT <= `BSV_ASSIGNMENT_DELAY {width {1'b0}} ; 
          end
        else
`endif
           begin
              if (ENQ) 
                D_OUT     <= `BSV_ASSIGNMENT_DELAY D_IN; 
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
                   $display( "Warning: FIFO1: %m -- Dequeuing from empty fifo" ) ; 
                end
              if ( ! FULL_N && ENQ && (!DEQ || guarded) ) 
                begin
                   enqerror =  1 ; 
                   $display( "Warning: FIFO1: %m -- Enqueuing to a full fifo" ) ; 
                end
           end 
     end
endmodule