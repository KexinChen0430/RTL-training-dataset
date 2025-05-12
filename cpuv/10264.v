module icache(
   input                           clk
  ,input                           reset
  ,input                           coretoic_pc_valid
  ,output                          coretoic_pc_retry
  ,input  I_coretoic_pc_type       coretoic_pc 
  ,output                          ictocore_valid
  ,input                           ictocore_retry
  ,output I_ictocore_type          ictocore
  ,input                           l1tlbtol1_fwd_valid
  ,output                          l1tlbtol1_fwd_retry
  ,input  I_l1tlbtol1_fwd_type     l1tlbtol1_fwd
  ,input                           l1tlbtol1_cmd_valid
  ,output                          l1tlbtol1_cmd_retry
  ,input  I_l1tlbtol1_cmd_type     l1tlbtol1_cmd
  ,output PF_cache_stats_type      cachetopf_stats
  ,output                          l1tol2tlb_req_valid
  ,input                           l1tol2tlb_req_retry
  ,output I_l1tol2tlb_req_type     l1tol2tlb_req
  ,output                          l1tol2_req_valid
  ,input                           l1tol2_req_retry
  ,output I_l1tol2_req_type        l1tol2_req
  ,input                           l2tol1_snack_valid
  ,output                          l2tol1_snack_retry
  ,input  I_l2tol1_snack_type      l2tol1_snack
  ,output                          l1tol2_snoop_ack_valid
  ,input                           l1tol2_snoop_ack_retry
  ,output I_l2snoop_ack_type       l1tol2_snoop_ack
);
endmodule