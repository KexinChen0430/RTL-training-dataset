
module x();

  reg  [(-1)+NumBnks:0] ibnk_sel_s;

  
  always @(lio_buscfg_brstlen2_sr or lio_buscfg_brstlen4_sr or m_cdq_haddr_sr)
      begin : PeelIntBnkAddr
        case ({lio_buscfg_brstlen4_sr,lio_buscfg_brstlen2_sr})

          2'b01: begin
                ibnk_sel_s = m_cdq_haddr_sr[1:0];
              end

          2'b10: begin
                ibnk_sel_s = m_cdq_haddr_sr[2:1];
              end

          default: begin
                ibnk_sel_s = m_cdq_haddr_sr[3:2];
              end

        endcase

      end
endmodule

