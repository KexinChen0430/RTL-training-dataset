
module ghrd_10as066n2_pr_region_controller_0(input  wire avl_csr_read,
                                             input  wire avl_csr_write,
                                             input  wire [1:0] avl_csr_address,
                                             input  wire [31:0] avl_csr_writedata,
                                             output wire [31:0] avl_csr_readdata,
                                             output wire bridge_freeze0_freeze,
                                             input  wire bridge_freeze0_illegal_request,
                                             output wire bridge_freeze1_freeze,
                                             input  wire bridge_freeze1_illegal_request,
                                             input  wire clock_clk,
                                             output wire pr_handshake_start_req,
                                             input  wire pr_handshake_start_ack,
                                             output wire pr_handshake_stop_req,
                                             input  wire pr_handshake_stop_ack,
                                             input  wire reset_reset,
                                             output wire reset_source_reset);


endmodule

