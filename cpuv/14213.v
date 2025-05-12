module altera_mem_if_hhp_qseq_synth_top
# ( 
    parameter APB_DATA_WIDTH     = 32, 
    parameter APB_ADDR_WIDTH     = 32, 
    parameter AVL_DATA_WIDTH     = 32, 
    parameter AVL_ADDR_WIDTH     = 16, 
    parameter AVL_MMR_DATA_WIDTH = 32, 
    parameter AVL_MMR_ADDR_WIDTH = 8,  
    parameter MEM_IF_DQS_WIDTH   = 1,  
    parameter MEM_IF_DQ_WIDTH    = 8,  
    parameter MEM_IF_DM_WIDTH    = 1,  
    parameter MEM_IF_CS_WIDTH    = 1   
) (
   );
endmodule