module assert_cycle_sequence_assume (clk, reset_n, event_sequence, seq_queue, xzcheck_enable);
       parameter num_cks = 2;
       parameter necessary_condition = 0;
       input clk, reset_n;
       input [num_cks-1:0] event_sequence, seq_queue;
       input xzcheck_enable;
endmodule