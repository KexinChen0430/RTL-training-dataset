
module action_decoder(input  clk,
                      input  enable,
                      input  [10:0] data,
                      output reg PXSERR_DIAG_X,
                      output reg SIRQ_DHR,
                      output reg SIRQ_DP,
                      output reg SIRQ_DS,
                      output reg SIRQ_IF,
                      output reg SIRQ_INF,
                      output reg SIRQ_PS,
                      output reg SIRQ_SDB,
                      output reg SIRQ_TFE,
                      output reg SIRQ_UF,
                      output reg PFSM_STARTED,
                      output reg PCMD_CR_CLEAR,
                      output reg PCMD_CR_SET,
                      output reg PXCI0_CLEAR,
                      output reg PXSSTS_DET_1,
                      output reg SSTS_DET_OFFLINE,
                      output reg SCTL_DET_CLEAR,
                      output reg HBA_RST_DONE,
                      output reg SET_UPDATE_SIG,
                      output reg UPDATE_SIG,
                      output reg UPDATE_ERR_STS,
                      output reg UPDATE_PIO,
                      output reg UPDATE_PRDBC,
                      output reg CLEAR_BSY_DRQ,
                      output reg CLEAR_BSY_SET_DRQ,
                      output reg SET_BSY,
                      output reg SET_STS_7F,
                      output reg SET_STS_80,
                      output reg XFER_CNTR_CLEAR,
                      output reg DECR_DWCR,
                      output reg DECR_DWCW,
                      output reg FIS_FIRST_FLUSH,
                      output reg CLEAR_CMD_TO_ISSUE,
                      output reg DMA_ABORT,
                      output reg DMA_PRD_IRQ_CLEAR,
                      output reg XMIT_COMRESET,
                      output reg SEND_SYNC_ESC,
                      output reg SET_OFFLINE,
                      output reg R_OK,
                      output reg R_ERR,
                      output reg EN_COMINIT,
                      output reg FETCH_CMD,
                      output reg ATAPI_XMIT,
                      output reg CFIS_XMIT,
                      output reg DX_XMIT,
                      output reg GET_DATA_FIS,
                      output reg GET_DSFIS,
                      output reg GET_IGNORE,
                      output reg GET_PSFIS,
                      output reg GET_RFIS,
                      output reg GET_SDBFIS,
                      output reg GET_UFIS);

  
  always @(posedge clk)
      begin
        PXSERR_DIAG_X <= data[0] && enable && data[1];
        SIRQ_DHR <= enable && data[2] && data[0];
        SIRQ_DP <= data[0] && data[3] && enable;
        SIRQ_DS <= data[4] && enable && data[0];
        SIRQ_IF <= data[5] && enable && data[0];
        SIRQ_INF <= data[0] && enable && data[6];
        SIRQ_PS <= data[7] && (data[0] && enable);
        SIRQ_SDB <= data[0] && (enable && data[8]);
        SIRQ_TFE <= data[0] && enable && data[9];
        SIRQ_UF <= enable && data[10] && data[0];
        PFSM_STARTED <= data[1] && (enable && data[2]);
        PCMD_CR_CLEAR <= enable && data[3] && data[1];
        PCMD_CR_SET <= data[4] && (data[1] && enable);
        PXCI0_CLEAR <= data[5] && (data[1] && enable);
        PXSSTS_DET_1 <= enable && data[6] && data[1];
        SSTS_DET_OFFLINE <= data[7] && (data[1] && enable);
        SCTL_DET_CLEAR <= data[1] && (enable && data[8]);
        HBA_RST_DONE <= data[9] && (data[1] && enable);
        SET_UPDATE_SIG <= data[1] && (enable && data[10]);
        UPDATE_SIG <= enable && data[3] && data[2];
        UPDATE_ERR_STS <= data[4] && enable && data[2];
        UPDATE_PIO <= data[5] && data[2] && enable;
        UPDATE_PRDBC <= enable && (data[6] && data[2]);
        CLEAR_BSY_DRQ <= data[2] && (data[7] && enable);
        CLEAR_BSY_SET_DRQ <= enable && data[2] && data[8];
        SET_BSY <= data[9] && (enable && data[2]);
        SET_STS_7F <= enable && data[10] && data[2];
        SET_STS_80 <= enable && (data[3] && data[4]);
        XFER_CNTR_CLEAR <= data[3] && (data[5] && enable);
        DECR_DWCR <= enable && data[6] && data[3];
        DECR_DWCW <= data[3] && (data[7] && enable);
        FIS_FIRST_FLUSH <= data[3] && (enable && data[8]);
        CLEAR_CMD_TO_ISSUE <= enable && data[9] && data[3];
        DMA_ABORT <= data[3] && (enable && data[10]);
        DMA_PRD_IRQ_CLEAR <= data[4] && (data[5] && enable);
        XMIT_COMRESET <= data[4] && (enable && data[6]);
        SEND_SYNC_ESC <= data[7] && (data[4] && enable);
        SET_OFFLINE <= data[4] && (enable && data[8]);
        R_OK <= enable && data[9] && data[4];
        R_ERR <= data[4] && (enable && data[10]);
        EN_COMINIT <= data[6] && (data[5] && enable);
        FETCH_CMD <= data[5] && (data[7] && enable);
        ATAPI_XMIT <= enable && data[8] && data[5];
        CFIS_XMIT <= data[5] && enable && data[9];
        DX_XMIT <= enable && data[10] && data[5];
        GET_DATA_FIS <= enable && data[6] && data[7];
        GET_DSFIS <= data[6] && (enable && data[8]);
        GET_IGNORE <= data[9] && (enable && data[6]);
        GET_PSFIS <= enable && (data[6] && data[10]);
        GET_RFIS <= data[7] && data[8] && enable;
        GET_SDBFIS <= enable && (data[7] && data[9]);
        GET_UFIS <= data[10] && (data[7] && enable);
      end
endmodule

