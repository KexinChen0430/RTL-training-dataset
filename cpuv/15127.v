module assert_handshake_assert (clk, reset_n, req, ack, first_req, xzcheck_enable);
       parameter min_ack_cycle = 0;
       parameter max_ack_cycle = 0;
       parameter req_drop = 0;
       parameter deassert_count = 0;
       parameter max_ack_length = 0;
       input clk, reset_n, req, ack, first_req, xzcheck_enable;
endmodule