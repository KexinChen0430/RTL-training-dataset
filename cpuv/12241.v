module ethmac
(
  wb_clk_i, wb_rst_i, wb_dat_i, wb_dat_o,
  wb_adr_i, wb_sel_i, wb_we_i, wb_cyc_i, wb_stb_i, wb_ack_o, wb_err_o,
  m_wb_adr_o, m_wb_sel_o, m_wb_we_o,
  m_wb_dat_o, m_wb_dat_i, m_wb_cyc_o,
  m_wb_stb_o, m_wb_ack_i, m_wb_err_i,
`ifdef ETH_WISHBONE_B3
  m_wb_cti_o, m_wb_bte_o,
`endif
  mtx_clk_pad_i, mtxd_pad_o, mtxen_pad_o, mtxerr_pad_o,
  mrx_clk_pad_i, mrxd_pad_i, mrxdv_pad_i, mrxerr_pad_i, mcoll_pad_i, mcrs_pad_i,
  mdc_pad_o, md_pad_i, md_pad_o, md_padoe_o,
  int_o
`ifdef ETH_BIST
  ,
  mbist_si_i,       
  mbist_so_o,       
  mbist_ctrl_i      
`endif
);
parameter Tp = 1;
input           wb_clk_i;     
input           wb_rst_i;     
input   [31:0]  wb_dat_i;     
output  [31:0]  wb_dat_o;     
output          wb_err_o;     
input   [11:2]  wb_adr_i;     
input    [3:0]  wb_sel_i;     
input           wb_we_i;      
input           wb_cyc_i;     
input           wb_stb_i;     
output          wb_ack_o;     
output  [31:0]  m_wb_adr_o;   
output   [3:0]  m_wb_sel_o;   
output          m_wb_we_o;    
input   [31:0]  m_wb_dat_i;   
output  [31:0]  m_wb_dat_o;   
output          m_wb_cyc_o;   
output          m_wb_stb_o;   
input           m_wb_ack_i;   
input           m_wb_err_i;   
wire    [29:0]  m_wb_adr_tmp;
`ifdef ETH_WISHBONE_B3
output   [2:0]  m_wb_cti_o;   
output   [1:0]  m_wb_bte_o;   
`endif
input           mtx_clk_pad_i; 
output   [3:0]  mtxd_pad_o;    
output          mtxen_pad_o;   
output          mtxerr_pad_o;  
input           mrx_clk_pad_i; 
input    [3:0]  mrxd_pad_i;    
input           mrxdv_pad_i;   
input           mrxerr_pad_i;  
input           mcoll_pad_i;   
input           mcrs_pad_i;    
input           md_pad_i;      
output          mdc_pad_o;     
output          md_pad_o;      
output          md_padoe_o;    
output          int_o;         
`ifdef ETH_BIST
input   mbist_si_i;            
output  mbist_so_o;            
input [`ETH_MBIST_CTRL_WIDTH - 1:0] mbist_ctrl_i; 
`endif
endmodule