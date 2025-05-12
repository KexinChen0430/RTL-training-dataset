module x ();
`define DMC_AG_HADDR_BADDR_BST2_RNG 1:0 
`define DMC_AG_HADDR_BADDR_BST4_RNG 2:1 
`define DMC_AG_HADDR_BADDR_BST8_RNG 3:2 
   reg [NumBnks-1:0] ibnk_sel_s; 
   always @(lio_buscfg_brstlen2_sr or lio_buscfg_brstlen4_sr or m_cdq_haddr_sr)
     begin : PeelIntBnkAddr 
        case ({lio_buscfg_brstlen4_sr,lio_buscfg_brstlen2_sr})
          2'b01: 
            begin
               ibnk_sel_s = m_cdq_haddr_sr[`DMC_AG_HADDR_BADDR_BST2_RNG];
            end
          2'b10: 
            begin
               ibnk_sel_s = m_cdq_haddr_sr[`DMC_AG_HADDR_BADDR_BST4_RNG];
            end
          default: 
            begin
               ibnk_sel_s = m_cdq_haddr_sr[`DMC_AG_HADDR_BADDR_BST8_RNG];
            end
        endcase
     end
endmodule