module SizedFIFO(CLK, RST_N, D_IN, ENQ, FULL_N, D_OUT, DEQ, EMPTY_N, CLR);
   parameter               p1width = 1; 
   parameter               p2depth = 3;
   parameter               p3cntr_width = 1; 
   parameter               guarded = 1;
   input                   CLK;
   input                   RST_N;
   input                   CLR;
   input [p1width - 1 : 0] D_IN;
   input                   ENQ;
   input                   DEQ;
   output                  FULL_N;
   output                  EMPTY_N;
   output [p1width - 1 : 0] D_OUT;
   reg                      not_ring_full;
   reg                      ring_empty;
   reg [p3cntr_width-1 : 0] head;
   wire [p3cntr_width-1 : 0] next_head;
   reg [p3cntr_width-1 : 0]  tail;
   wire [p3cntr_width-1 : 0] next_tail;
   reg [p1width - 1 : 0]     arr[0: ((p2depth >= 2) ? (p2depth-2) : 0)];
   reg [p1width - 1 : 0]     D_OUT;
   reg                       hasodata;
   wire [p3cntr_width-1:0]   depthLess2 = p2depth - 'd2 ;
   wire [p3cntr_width-1 : 0] incr_tail;
   wire [p3cntr_width-1 : 0] incr_head;
   assign                    incr_tail = tail + 1'b1 ;
   assign                    incr_head = head + 1'b1 ;
   assign    next_head = (head == depthLess2[p3cntr_width-1:0] ) ? 'b0 : incr_head ;
   assign    next_tail = (tail == depthLess2[p3cntr_width-1:0] ) ? 'b0 : incr_tail ;
   assign    EMPTY_N = hasodata;
   assign    FULL_N  = not_ring_full;
   integer   i;
`ifdef BSV_NO_INITIAL_BLOCKS
`else 
   initial
     begin : initial_block
        D_OUT         = {((p1width + 1)/2){2'b10}} ;
        ring_empty    = 1'b1;
        not_ring_full = 1'b1;
        hasodata      = 1'b0;
        head          = {p3cntr_width {1'b0}} ;
        tail          = {p3cntr_width {1'b0}} ;
        for (i = 0; i <= p2depth - 2 && p2depth > 2; i = i + 1)
          begin
             arr[i]   = D_OUT ;
          end
     end
`endif 
   always @(posedge CLK  )
     begin
        if (!RST_N)
          begin
             head <= `BSV_ASSIGNMENT_DELAY {p3cntr_width {1'b0}} ;
             tail <= `BSV_ASSIGNMENT_DELAY {p3cntr_width {1'b0}} ;
             ring_empty <= `BSV_ASSIGNMENT_DELAY 1'b1;
             not_ring_full <= `BSV_ASSIGNMENT_DELAY 1'b1;
             hasodata <= `BSV_ASSIGNMENT_DELAY 1'b0;
          end 
        else
         begin
            if (!CLR && ENQ && ((DEQ && !ring_empty) || (!DEQ && hasodata && not_ring_full)))
              begin
                 arr[tail] <= `BSV_ASSIGNMENT_DELAY D_IN;
              end
            if (CLR)
              begin
                 head <= `BSV_ASSIGNMENT_DELAY {p3cntr_width {1'b0}} ;
                 tail <= `BSV_ASSIGNMENT_DELAY {p3cntr_width {1'b0}} ;
                 ring_empty <= `BSV_ASSIGNMENT_DELAY 1'b1;
                 not_ring_full <= `BSV_ASSIGNMENT_DELAY 1'b1;
                 hasodata <= `BSV_ASSIGNMENT_DELAY 1'b0;
              end 
            else if (DEQ && ENQ )
              begin
                 if (ring_empty)
                   begin
                      D_OUT <= `BSV_ASSIGNMENT_DELAY D_IN;
                   end
                 else
                   begin
                      tail <= `BSV_ASSIGNMENT_DELAY next_tail;
                      D_OUT <= `BSV_ASSIGNMENT_DELAY arr[head];
                      head <= `BSV_ASSIGNMENT_DELAY next_head;
                   end
              end 
            else if ( DEQ )
              begin
                 if (ring_empty)
                   begin
                      hasodata <= `BSV_ASSIGNMENT_DELAY 1'b0;
                   end
                 else
                   begin
                      D_OUT <= `BSV_ASSIGNMENT_DELAY arr[head];
                      head <= `BSV_ASSIGNMENT_DELAY next_head;
                      not_ring_full <= `BSV_ASSIGNMENT_DELAY 1'b1;
                      ring_empty <= `BSV_ASSIGNMENT_DELAY next_head == tail ;
                   end
              end 
            else if (ENQ)
              begin
                 if (! hasodata)
                   begin
                      D_OUT <= `BSV_ASSIGNMENT_DELAY D_IN;
                      hasodata <= `BSV_ASSIGNMENT_DELAY 1'b1;
                   end
                 else if ( not_ring_full ) 
                   begin
                      tail <= `BSV_ASSIGNMENT_DELAY next_tail;
                      ring_empty <= `BSV_ASSIGNMENT_DELAY 1'b0;
                      not_ring_full <= `BSV_ASSIGNMENT_DELAY ! (next_tail == head) ;
                   end
              end 
         end 
     end 
   always@(posedge CLK)
     begin: error_checks
        reg deqerror, enqerror ;
        deqerror =  0;
        enqerror = 0;
        if ( RST_N )
           begin
              if ( ! EMPTY_N && DEQ )
                begin
                   deqerror = 1 ;
                   $display( "Warning: SizedFIFO: %m -- Dequeuing from empty fifo" ) ;
                end
              if ( ! FULL_N && ENQ && (!DEQ || guarded) )
                begin
                   enqerror =  1 ;
                   $display( "Warning: SizedFIFO: %m -- Enqueuing to a full fifo" ) ;
                end
           end
     end 
   initial
     begin : parameter_assertions
        integer ok ;
        ok = 1 ;
        if ( p2depth <= 2 )
          begin
             ok = 0;
             $display ( "ERROR SizedFIFO.v: depth parameter must be greater than 2" ) ;
          end
        if ( p3cntr_width <= 0 )
          begin
             ok = 0;
             $display ( "ERROR SizedFIFO.v: width parameter must be greater than 0" ) ;
          end
        if ( ok == 0 ) $finish ;
      end 
endmodule