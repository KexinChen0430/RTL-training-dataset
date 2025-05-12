module FIFO2(CLK,
             RST_N,
             D_IN,
             ENQ,
             FULL_N,
             D_OUT,
             DEQ,
             EMPTY_N,
             CLR);
   parameter width = 1;
   parameter guarded = 1;
   input     CLK ;
   input     RST_N ;
   input [width - 1 : 0] D_IN;
   input                 ENQ;
   input                 DEQ;
   input                 CLR ;
   output                FULL_N;
   output                EMPTY_N;
   output [width - 1 : 0] D_OUT;
   reg                    full_reg;
   reg                    empty_reg;
   reg [width - 1 : 0]    data0_reg;
   reg [width - 1 : 0]    data1_reg;
   assign                 FULL_N = full_reg ;
   assign                 EMPTY_N = empty_reg ;
   assign                 D_OUT = data0_reg ;
   wire                   d0di = (ENQ && ! empty_reg ) || ( ENQ && DEQ && full_reg ) ;
   wire                   d0d1 = DEQ && ! full_reg ;
   wire                   d0h = ((! DEQ) && (! ENQ )) || (!DEQ && empty_reg ) || ( ! ENQ &&full_reg) ;
   wire                   d1di = ENQ & empty_reg ;
`ifdef BSV_NO_INITIAL_BLOCKS
`else 
   initial
     begin
        data0_reg   = {((width + 1)/2) {2'b10}} ;
        data1_reg  = {((width + 1)/2) {2'b10}} ;
        empty_reg = 1'b0;
        full_reg  = 1'b1;
     end 
`endif 
   always@(posedge CLK )
     begin
        if (!RST_N)
          begin
             empty_reg <= `BSV_ASSIGNMENT_DELAY 1'b0;
             full_reg  <= `BSV_ASSIGNMENT_DELAY 1'b1;
          end 
        else
          begin
             if (CLR)
               begin
                  empty_reg <= `BSV_ASSIGNMENT_DELAY 1'b0;
                  full_reg  <= `BSV_ASSIGNMENT_DELAY 1'b1;
               end 
             else if ( ENQ && ! DEQ ) 
               begin
                  empty_reg <= `BSV_ASSIGNMENT_DELAY 1'b1;
                  full_reg <= `BSV_ASSIGNMENT_DELAY ! empty_reg ;
               end
             else if ( DEQ && ! ENQ )
               begin
                  full_reg  <= `BSV_ASSIGNMENT_DELAY 1'b1;
                  empty_reg <= `BSV_ASSIGNMENT_DELAY ! full_reg;
               end 
          end 
     end 
   always@(posedge CLK  )
     begin
          begin
             data0_reg  <= `BSV_ASSIGNMENT_DELAY
                           {width{d0di}} & D_IN | {width{d0d1}} & data1_reg | {width{d0h}} & data0_reg ;
             data1_reg <= `BSV_ASSIGNMENT_DELAY
                          d1di ? D_IN : data1_reg ;
          end 
     end 
   always@(posedge CLK)
     begin: error_checks
        reg deqerror, enqerror ;
        deqerror =  0;
        enqerror = 0;
        if ( RST_N )
          begin
             if ( ! empty_reg && DEQ )
               begin
                  deqerror =  1;
                  $display( "Warning: FIFO2: %m -- Dequeuing from empty fifo" ) ;
               end
             if ( ! full_reg && ENQ && (!DEQ || guarded) )
               begin
                  enqerror = 1;
                  $display( "Warning: FIFO2: %m -- Enqueuing to a full fifo" ) ;
               end
          end
     end 
endmodule