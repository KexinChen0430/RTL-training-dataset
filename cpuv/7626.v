module FswBypassArbiter ( 
                         bp_grant3, bp_grant2, bp_grant1, bp_grant0, bp_grant_cycle, bp_grant_cycle_d1, bp_grant_cycle_d2, 
                         bp_next_winner, bp_next_winner_d1, bp_next_winner_d2, 
                         bp_nextxbe, bp_nextxbe_d1, bp_nextxbe_d2, 
                         bp_hold_wait_vector, bp_hold_wait_vector_d1, 
                         bp_header, bp_header_d1, bp_header_d2, 
                         bp_select, bp_select_d1, bp_select_d2, 
                         lreset_l, sclk, bp_arb_enable, 
                         sop3, sop3_data, sop3_bpcontext, 
                         sop2, sop2_data, sop2_bpcontext, 
                         sop1, sop1_data, sop1_bpcontext, 
                         sop0, sop0_data, sop0_bpcontext, 
                         poolmask, bufbusy_mask 
                         ) ;
   input        lreset_l; 
   input        sclk; 
   input        bp_arb_enable; 
   output       bp_grant3; 
   output       bp_grant2; 
   output       bp_grant1; 
   output       bp_grant0; 
   output       bp_grant_cycle; 
   output       bp_grant_cycle_d1; 
   output       bp_grant_cycle_d2; 
   output [1:0] bp_next_winner; 
   output [1:0] bp_next_winner_d1; 
   output [1:0] bp_next_winner_d2; 
   output [3:0] bp_nextxbe; 
   output [3:0] bp_nextxbe_d1; 
   output [3:0] bp_nextxbe_d2; 
   output [5:0] bp_hold_wait_vector; 
   output [5:0] bp_hold_wait_vector_d1; 
   output       bp_header; 
   output       bp_header_d1; 
   output       bp_header_d2; 
   output       bp_select; 
   output       bp_select_d1; 
   output       bp_select_d2; 
   input        sop3; 
   input [63:0] sop3_data; 
   input [5:0]  sop3_bpcontext; 
   input        sop2; 
   input [63:0] sop2_data; 
   input [5:0]  sop2_bpcontext; 
   input        sop1; 
   input [63:0] sop1_data; 
   input [5:0]  sop1_bpcontext; 
   input        sop0; 
   input [63:0] sop0_data; 
   input [5:0]  sop0_bpcontext; 
   input [15:0] poolmask; 
   input [63:0] bufbusy_mask; 
endmodule 