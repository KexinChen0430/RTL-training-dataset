
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
        PXSERR_DIAG_X <= data[0] && (enable && data[1]);
        SIRQ_DHR <= data[0] && enable && data[2];
        SIRQ_DP <= data[0] && enable && data[3];
        SIRQ_DS <= data[0] && enable && data[4];
        SIRQ_IF <= data[5] && (data[0] && enable);
        SIRQ_INF <= data[6] && (data[0] && enable);
        SIRQ_PS <= data[7] && enable && data[0];
        SIRQ_SDB <= data[8] && (data[0] && enable);
        SIRQ_TFE <= data[0] && (enable && data[9]);
        SIRQ_UF <= data[0] && (enable && data[10]);
        PFSM_STARTED <= data[2] && enable && data[1];
        PCMD_CR_CLEAR <= data[1] && (enable && data[3]);
        PCMD_CR_SET <= enable && data[1] && data[4];
        PXCI0_CLEAR <= data[1] && (data[5] && enable);
        PXSSTS_DET_1 <= enable && data[6] && data[1];
        SSTS_DET_OFFLINE <= data[1] && (data[7] && enable);
        SCTL_DET_CLEAR <= enable && (data[1] && data[8]);
        HBA_RST_DONE <= data[1] && (enable && data[9]);
        SET_UPDATE_SIG <= enable && data[10] && data[1];
        UPDATE_SIG <= data[2] && (enable && data[3]);
        UPDATE_ERR_STS <= data[4] && (data[2] && enable);
        UPDATE_PIO <= data[2] && (data[5] && enable);
        UPDATE_PRDBC <= data[6] && (data[2] && enable);
        CLEAR_BSY_DRQ <= data[2] && data[7] && enable;
        CLEAR_BSY_SET_DRQ <= data[2] && enable && data[8];
        SET_BSY <= data[2] && (enable && data[9]);
        SET_STS_7F <= enable && (data[2] && data[10]);
        SET_STS_80 <= data[4] && enable && data[3];
        XFER_CNTR_CLEAR <= data[5] && enable && data[3];
        DECR_DWCR <= enable && data[3] && data[6];
        DECR_DWCW <= data[3] && (data[7] && enable);
        FIS_FIRST_FLUSH <= enable && data[3] && data[8];
        CLEAR_CMD_TO_ISSUE <= enable && data[9] && data[3];
        DMA_ABORT <= data[3] && data[10] && enable;
        DMA_PRD_IRQ_CLEAR <= data[4] && (data[5] && enable);
        XMIT_COMRESET <= data[4] && enable && data[6];
        SEND_SYNC_ESC <= data[7] && (data[4] && enable);
        SET_OFFLINE <= enable && (data[8] && data[4]);
        R_OK <= enable && data[9] && data[4];
        R_ERR <= enable && data[10] && data[4];
        EN_COMINIT <= data[5] && enable && data[6];
        FETCH_CMD <= data[7] && (data[5] && enable);
        ATAPI_XMIT <= enable && data[8] && data[5];
        CFIS_XMIT <= enable && data[9] && data[5];
        DX_XMIT <= enable && (data[10] && data[5]);
        GET_DATA_FIS <= data[6] && (data[7] && enable);
        GET_DSFIS <= data[8] && (enable && data[6]);
        GET_IGNORE <= data[9] && (enable && data[6]);
        GET_PSFIS <= data[10] && (enable && data[6]);
        GET_RFIS <= data[7] && (enable && data[8]);
        GET_SDBFIS <= data[7] && enable && data[9];
        GET_UFIS <= data[7] && (enable && data[10]);
      end
endmodule

