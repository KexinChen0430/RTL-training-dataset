
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
        SIRQ_DHR <= enable && data[2] && data[0];
        SIRQ_DP <= data[3] && (enable && data[0]);
        SIRQ_DS <= enable && data[0] && data[4];
        SIRQ_IF <= data[5] && (enable && data[0]);
        SIRQ_INF <= data[0] && (enable && data[6]);
        SIRQ_PS <= data[0] && (data[7] && enable);
        SIRQ_SDB <= data[8] && (enable && data[0]);
        SIRQ_TFE <= data[9] && data[0] && enable;
        SIRQ_UF <= data[0] && (enable && data[10]);
        PFSM_STARTED <= enable && data[2] && data[1];
        PCMD_CR_CLEAR <= data[3] && (enable && data[1]);
        PCMD_CR_SET <= data[1] && (enable && data[4]);
        PXCI0_CLEAR <= data[1] && (enable && data[5]);
        PXSSTS_DET_1 <= data[1] && data[6] && enable;
        SSTS_DET_OFFLINE <= data[7] && (enable && data[1]);
        SCTL_DET_CLEAR <= data[8] && (enable && data[1]);
        HBA_RST_DONE <= enable && data[1] && data[9];
        SET_UPDATE_SIG <= data[10] && (enable && data[1]);
        UPDATE_SIG <= data[2] && (enable && data[3]);
        UPDATE_ERR_STS <= data[2] && (enable && data[4]);
        UPDATE_PIO <= enable && data[2] && data[5];
        UPDATE_PRDBC <= enable && data[2] && data[6];
        CLEAR_BSY_DRQ <= data[7] && (enable && data[2]);
        CLEAR_BSY_SET_DRQ <= data[8] && (enable && data[2]);
        SET_BSY <= data[2] && (enable && data[9]);
        SET_STS_7F <= data[10] && (enable && data[2]);
        SET_STS_80 <= data[4] && (enable && data[3]);
        XFER_CNTR_CLEAR <= enable && data[3] && data[5];
        DECR_DWCR <= data[3] && (enable && data[6]);
        DECR_DWCW <= data[7] && (enable && data[3]);
        FIS_FIRST_FLUSH <= enable && (data[8] && data[3]);
        CLEAR_CMD_TO_ISSUE <= data[3] && (enable && data[9]);
        DMA_ABORT <= data[3] && (enable && data[10]);
        DMA_PRD_IRQ_CLEAR <= enable && data[4] && data[5];
        XMIT_COMRESET <= data[4] && (enable && data[6]);
        SEND_SYNC_ESC <= data[4] && (data[7] && enable);
        SET_OFFLINE <= data[4] && data[8] && enable;
        R_OK <= data[9] && data[4] && enable;
        R_ERR <= data[10] && (enable && data[4]);
        EN_COMINIT <= data[6] && (enable && data[5]);
        FETCH_CMD <= data[7] && enable && data[5];
        ATAPI_XMIT <= data[8] && enable && data[5];
        CFIS_XMIT <= data[5] && (enable && data[9]);
        DX_XMIT <= enable && data[10] && data[5];
        GET_DATA_FIS <= data[6] && (data[7] && enable);
        GET_DSFIS <= enable && data[6] && data[8];
        GET_IGNORE <= enable && data[9] && data[6];
        GET_PSFIS <= enable && data[10] && data[6];
        GET_RFIS <= enable && (data[7] && data[8]);
        GET_SDBFIS <= data[9] && (data[7] && enable);
        GET_UFIS <= data[10] && data[7] && enable;
      end
endmodule

