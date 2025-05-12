module sm_ref
  (
   input      mem_clk, 
   input      hreset_n, 
   input      ref_gnt, 
   input      svga_ack, 
   input      c_cr11_b6, 
   input      sync_c_crt_line_end, 
   output     ref_svga_req, 
   output     ref_req, 
   output     m_t_ref_n, 
   output     ref_cycle_done 
   );