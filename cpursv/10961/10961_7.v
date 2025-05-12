
module tenv_link;

  reg  [1:0] pmain_wr,pmain_rd,pexc_wr,pexc_rd;
  wire pmem_mux;

  assign tenv_test.dmem_adr[31:2] = cpucore.dmem_adr_o;
  assign tenv_test.dmem_adr[1:0] = 2'b00;
  assign tenv_test.dmem_stb = cpucore.dmem_stb_o;
  assign tenv_test.dmem_we = cpucore.dmem_we_o;
  assign tenv_test.dmem_dat_fromcpu = cpucore.dmem_dat_o;
  assign tenv_test.pmem_adr[31:2] = cpucore.pmem_adr_o;
  assign tenv_test.pmem_adr[1:0] = 2'b00;
  assign cpucore.sys_clk = tenv_test.clk;
  assign #1 cpucore.sys_rst = tenv_test.rst;
  assign #1 cpucore.sys_int = tenv_test.int;
  assign #1 cpucore.pmem_dat_i = pmem_mux ? tenv_pexc.dat_o : tenv_pmain.dat_o;
  assign #1 cpucore.pmem_ack_i = pmem_mux ? tenv_pexc.ack_o : tenv_pmain.ack_o;
  assign #1 cpucore.pmem_stall_i = pmem_mux ? tenv_pexc.stall_o : tenv_pmain.stall_o;
  assign #1 cpucore.dmem_dat_i = tenv_dmem.dat_o;
  assign #1 cpucore.dmem_ack_i = tenv_dmem.ack_o;
  assign #1 cpucore.dmem_stall_i = tenv_dmem.stall_o;
  assign tenv_pexc.access_time = tenv_test.mem_timing;
  assign tenv_pexc.clk_i = tenv_test.clk;
  assign #1 tenv_pexc.rst_i = tenv_test.rst;
  assign tenv_pexc.cyc_i = cpucore.pmem_cyc_o;
  assign tenv_pexc.stb_i = (cpucore.pmem_stb_o & cpucore.pmem_adr_o[31:28]) == 4'h8;
  assign tenv_pexc.adr_i = cpucore.pmem_adr_o[14:2];
  assign tenv_pexc.we_i = 1'b0;
  assign tenv_pexc.sel_i = 4'b1111;
  assign tenv_pexc.dat_i = 32'd0;
  assign tenv_pmain.access_time = tenv_test.mem_timing;
  assign tenv_pmain.clk_i = tenv_test.clk;
  assign #1 tenv_pmain.rst_i = tenv_test.rst;
  assign tenv_pmain.cyc_i = cpucore.pmem_cyc_o;
  assign tenv_pmain.stb_i = (cpucore.pmem_stb_o & cpucore.pmem_adr_o[31:28]) == 4'hB;
  assign tenv_pmain.adr_i = cpucore.pmem_adr_o[14:2];
  assign tenv_pmain.we_i = 1'b0;
  assign tenv_pmain.sel_i = 4'b1111;
  assign tenv_pmain.dat_i = 32'd0;
  assign pmem_mux = ((cpucore.pmem_adr_o[31:28] == (4'h8 & pmain_wr)) == pmain_rd) | ((cpucore.pmem_adr_o[31:28] == (4'hB & pexc_wr)) != pexc_rd);
  
  always @(posedge tenv_test.clk)
      if (tenv_test.rst) 
        begin
          pmain_wr <= 0;
          pmain_rd <= 0;
          pexc_wr <= 0;
          pexc_rd <= 0;
        end
      else 
        begin
          pmain_wr <= (tenv_pmain.stb_i & !tenv_pmain.stall_o) ? (pmain_wr+1'b1) : pmain_wr;
          pmain_rd <= tenv_pmain.ack_o ? (pmain_rd+1'b1) : pmain_rd;
          pexc_wr <= (!tenv_pexc.stall_o & tenv_pexc.stb_i) ? (pexc_wr+1'b1) : pexc_wr;
          pexc_rd <= tenv_pexc.ack_o ? (1'b1+pexc_rd) : pexc_rd;
        end
  assign tenv_dmem.access_time = tenv_test.mem_timing;
  assign tenv_dmem.clk_i = tenv_test.clk;
  assign #1 tenv_dmem.rst_i = tenv_test.rst;
  assign tenv_dmem.cyc_i = cpucore.dmem_cyc_o;
  assign tenv_dmem.stb_i = cpucore.dmem_stb_o;
  assign tenv_dmem.we_i = cpucore.dmem_we_o;
  assign tenv_dmem.sel_i = cpucore.dmem_sel_o;
  assign tenv_dmem.adr_i = cpucore.dmem_adr_o[7:2];
  assign tenv_dmem.dat_i = cpucore.dmem_dat_o;
endmodule

