module tx_arbiter
    #(parameter C_TXC_PRIORITY = 1,
      parameter C_TXR_PRIORITY = 1)
    (
     input  CLK,
     input  RST_IN,
     input  TX_TLP_READY,
     output TXR_TLP_READY,
     input  TXR_TLP_VALID,
     input  TXR_TLP_START_FLAG,
     input  TXR_TLP_END_FLAG,
     output TXC_TLP_READY,
     input  TXC_TLP_VALID,
     input  TXC_TLP_START_FLAG,
     input  TXC_TLP_END_FLAG);