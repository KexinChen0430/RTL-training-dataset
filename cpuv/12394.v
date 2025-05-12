if (cnet_hit && !p2n_full) begin
   if (pci_data_vld || (!cnet_we && cnet_trans_start)) begin
      p2n_data_nxt = pci_data; 
      p2n_addr_nxt = pci_addr[`CPCI_CNET_ADDR_WIDTH-1:0]; 
      p2n_req_nxt = 1'b1; 
      p2n_we_nxt = cnet_we; 
      if (!cnet_we) begin
         rd_state_nxt = `CR_Wait_CNET; 
         rd_addr_nxt = pci_addr[`CPCI_CNET_ADDR_WIDTH-1:0]; 
      end
   end
end
`CR_Wait_CNET : begin
   if (n2p_rd_rdy)
      rd_state_nxt = `CR_Read_Result;
end
`CR_Wait_PCI : begin
   if (cnet_trans_start && !cnet_we)
      rd_state_nxt = `CR_Read_Result;
end
`CR_Read_Result : begin
   if (cnet_trans_done)
      rd_state_nxt = `CR_Idle;
end
default : begin
   rd_state_nxt = `CR_Idle;
end
endcase
always @(posedge clk) begin
   cnet_data <= cnet_data_nxt; 
end
always @* begin
   cnet_data_nxt = cnet_data; 
   if (reset)
      cnet_data_nxt = 'h0; 
   else if (rd_state == `CR_Wait_CNET && n2p_rd_rdy)
      cnet_data_nxt = n2p_data; 
end
assign cnet_retry = !cnet_reprog && cnet_hit &&
                    (!cnet_we && rd_state != `CR_Wait_PCI) ||
                    (rd_state != `CR_Idle && rd_addr != pci_addr[`CPCI_CNET_ADDR_WIDTH-1:0]) ||
                    (rd_state != `CR_Wait_PCI && p2n_full);
always @(posedge clk)
   cnet_hit_d1 <= cnet_hit; 
assign cnet_trans_start = ~cnet_hit_d1 & cnet_hit; 
assign cnet_trans_done = cnet_hit_d1 & ~cnet_hit; 
assign cnet_vld = (rd_state == `CR_Wait_PCI && cnet_trans_start ||
                   rd_state == `CR_Read_Result) &&
                  rd_addr == pci_addr[`CPCI_CNET_ADDR_WIDTH-1:0];
always @* begin
   if (rd_state != `CR_Idle && cnet_hit && !cnet_reprog && rd_addr != pci_addr[`CPCI_CNET_ADDR_WIDTH-1:0])
      $display($time, " Warning: Requested access to CNET register %x while there is an outstanding request to %x", pci_addr[`CPCI_CNET_ADDR_WIDTH-1:0], rd_addr);
   if (rd_state != `CR_Idle && cnet_hit && cnet_we)
      $display($time, " Warning: Write request to CNET register %x during outstanding read request to %x", pci_addr[`CPCI_CNET_ADDR_WIDTH-1:0], rd_addr);
end