module assert_cycle_sequence_cover (clk, reset_n, event_sequence, seq_queue);
       parameter num_cks = 4;
       parameter necessary_condition = 0;
       parameter OVL_COVER_BASIC_ON = 1;
       input clk, reset_n;
       input [num_cks-1:0] event_sequence, seq_queue;
endmodule