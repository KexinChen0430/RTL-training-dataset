module emmu (
   mi_dout, emesh_access_out, emesh_packet_out, emesh_packet_hi_out,
   reset, rd_clk, wr_clk, mmu_en, mmu_bp, mi_en, mi_we, mi_addr,
   mi_din, emesh_access_in, emesh_packet_in, emesh_rd_wait,
   emesh_wr_wait
   );