module to verify the clock frequencies.
always @(posedge clk) 
begin
   if (reset) begin 
     clk_chk_p_max <= 'h0;
     clk_chk_n_exp <= 'h0;
   end
   else begin 
      if (reg_we && pci_data_vld && pci_addr[11:2] == `CPCI_CLOCK_CHECK_P_MAX) 
	clk_chk_p_max <= pci_data;
      else
	if (reg_we && pci_data_vld && pci_addr[11:2] == `CPCI_CLOCK_CHECK_N_EXP) 
	  clk_chk_n_exp <= pci_data;
   end
end
reg [`PCI_DATA_WIDTH - 1:0] cpci_reset_cnt; 
always @(posedge clk) 
  if (reg_we && pci_data_vld && pci_addr[11:2] == `CPCI_CPCI_RESET_CNT) 
    cpci_reset_cnt <= pci_data;
  else if (reg_we && pci_data_vld && pci_addr[11:2] == `CPCI_RESET) begin 
     cpci_reset_cnt <= cpci_reset_cnt + 1;
  end
always @* 
begin : outputmux
   case (pci_addr[11:2]) 
      `CPCI_ID      : reg_data = id_data;
      `CPCI_BOARD_ID: reg_data = board_id_data;
      `CPCI_CTRL    : reg_data = ctrl_data;
      `CPCI_RESET   : reg_data = 'h0;
      `CPCI_ERROR   : reg_data = error_status;
      `CPCI_DUMMY   : reg_data = test_data;
      `CPCI_INTERRUPT_MASK   : reg_data = interrupt_mask;
      `CPCI_INTERRUPT_STATUS : reg_data = interrupt_flags;
      `CPCI_CNET_CLK_SEL  : reg_data = cnet_clk_sel;
      `CPCI_REPROG_DATA   : reg_data = 'h0;
      `CPCI_REPROG_STATUS : reg_data = prog_status;
      `CPCI_REPROG_CTRL   : reg_data = 'h0;
      `CPCI_DMA_ADDR_I : reg_data = dma_rd_addr;
      `CPCI_DMA_ADDR_E : reg_data = dma_wr_addr;
      `CPCI_DMA_SIZE_I : reg_data = dma_rd_size_q;
      `CPCI_DMA_SIZE_E : reg_data = dma_wr_size;
      `CPCI_DMA_CTRL_I : reg_data = dma_rd_ctrl;
      `CPCI_DMA_CTRL_E : reg_data = dma_wr_ctrl;
      `CPCI_DMA_XFER_TIME    : reg_data = dma_time;
      `CPCI_DMA_RETRIES      : reg_data = dma_retries;
      `CPCI_CNET_READ_TIME   : reg_data = cnet_rd_time;
      `CPCI_DMA_INGRESS_PKT_CNT : reg_data = ingress_pkt_cnt;
      `CPCI_DMA_EGRESS_PKT_CNT  : reg_data = egress_pkt_cnt;
      `CPCI_CPCI_REG_READ_CNT   : reg_data = cpci_reg_rd_cnt;
      `CPCI_CPCI_REG_WRITE_CNT  : reg_data = cpci_reg_wr_cnt;
      `CPCI_CNET_REG_READ_CNT   : reg_data = cnet_reg_rd_cnt;
      `CPCI_CNET_REG_WRITE_CNT  : reg_data = cnet_reg_wr_cnt;
      `CPCI_CLOCK_CHECK_N_CLK : reg_data = n_clk_count;
      `CPCI_CLOCK_CHECK_P_MAX : reg_data = clk_chk_p_max;
      `CPCI_CLOCK_CHECK_N_EXP : reg_data = clk_chk_n_exp;
      `CPCI_PCI_CLK_CNT       : reg_data = cnet_pci_clk_cnt;
      `CPCI_CPCI_RESET_CNT    : reg_data = cpci_reset_cnt;
      default           : reg_data = 32'h dead_beef; 
   endcase
end
assign reg_vld = !reg_we; 
assign reset = pci_reset | reg_reset; 
assign intr_req = |(interrupt_flags & ~interrupt_mask); 
always @(posedge clk) 
begin
   reg_hit_d1 <= reg_hit; 
   reg_we_d1 <= reg_we; 
   cnet_hit_d1 <= cnet_hit; 
   cnet_we_d1 <= cnet_we; 
   pci_addr_d1 <= pci_addr; 
end
endmodule