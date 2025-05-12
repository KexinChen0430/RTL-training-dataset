module pcie_core_wrap
  (
   output [`NLANES-1:0]    pci_exp_txp,
   output [`NLANES-1:0]    pci_exp_txn,
   input [`NLANES-1:0] 	   pci_exp_rxp,
   input [`NLANES-1:0] 	   pci_exp_rxn,
   input 		   sys_clk_p,
   input 		   sys_clk_n,
   input 		   sys_rst_n,
   output reg [15:0] 	   pci_id = 16'hDEAD,
   input 		   interrupt,
   output reg 		   interrupt_rdy = 0,
   output reg 		   pci_reset = 0,
   output reg 		   clock = 0,
   input [9*`NLANES-1:0]   gt_drp_address,
   input [`NLANES-1:0] 	   gt_drp_en,
   input [16*`NLANES-1:0]  gt_drp_di,
   output [16*`NLANES-1:0] gt_drp_do,
   output [`NLANES-1:0]    gt_drp_ready,
   input [`NLANES-1:0] 	   gt_drp_we,
   output 		   gt_drp_clock,
   output reg 		   s_axis_tx_tready = 0,
   input [63:0] 	   s_axis_tx_tdata,
   input 		   s_axis_tx_1dw,
   input 		   s_axis_tx_tlast,
   input 		   s_axis_tx_tvalid,
   output reg 		   m_axis_rx_tvalid = 0,
   output reg 		   m_axis_rx_tlast = 0,
   output reg [63:0] 	   m_axis_rx_tdata = 0
   );
   always @ (posedge clock)
     interrupt_rdy <= interrupt;
endmodule