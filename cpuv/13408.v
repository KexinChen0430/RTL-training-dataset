module translation_altera
    #(
      parameter C_PCI_DATA_WIDTH = 128 
      )
    (
     input                          CLK, 
     input                          RST_IN, 
     input [C_PCI_DATA_WIDTH-1:0]   RX_ST_DATA, 
     input [0:0]                    RX_ST_EOP, 
     input [0:0]                    RX_ST_SOP, 
     input [0:0]                    RX_ST_VALID, 
     output                         RX_ST_READY, 
     input [0:0]                    RX_ST_EMPTY, 
     output [C_PCI_DATA_WIDTH-1:0]  TX_ST_DATA, 
     output [0:0]                   TX_ST_VALID, 
     input                          TX_ST_READY, 
     output [0:0]                   TX_ST_EOP, 
     output [0:0]                   TX_ST_SOP, 
     output [0:0]                   TX_ST_EMPTY, 
     input [`SIG_CFG_CTL_W-1:0]     TL_CFG_CTL, 
     input [`SIG_CFG_ADD_W-1:0]     TL_CFG_ADD, 
     input [`SIG_CFG_STS_W-1:0]     TL_CFG_STS, 
     input [`SIG_FC_CPLH_W-1:0]     KO_CPL_SPC_HEADER, 
     input [`SIG_FC_CPLD_W-1:0]     KO_CPL_SPC_DATA, 
     input                          APP_MSI_ACK, 
     output                         APP_MSI_REQ, 
     output [C_PCI_DATA_WIDTH-1:0]  RX_TLP, 
     output                         RX_TLP_VALID, 
     output                         RX_TLP_START_FLAG, 
     output [`SIG_OFFSET_W-1:0]     RX_TLP_START_OFFSET, 
     output                         RX_TLP_END_FLAG, 
     output [`SIG_OFFSET_W-1:0]     RX_TLP_END_OFFSET, 
     output [`SIG_BARDECODE_W-1:0]  RX_TLP_BAR_DECODE, 
     input                          RX_TLP_READY, 
     output                         TX_TLP_READY, 
     input [C_PCI_DATA_WIDTH-1:0]   TX_TLP, 
     input                          TX_TLP_VALID, 
     input                          TX_TLP_START_FLAG, 
     input [`SIG_OFFSET_W-1:0]      TX_TLP_START_OFFSET, 
     input                          TX_TLP_END_FLAG, 
     input [`SIG_OFFSET_W-1:0]      TX_TLP_END_OFFSET, 
     output [`SIG_CPLID_W-1:0]      CONFIG_COMPLETER_ID, 
     output                         CONFIG_BUS_MASTER_ENABLE, 
     output [`SIG_LINKWIDTH_W-1:0]  CONFIG_LINK_WIDTH, 
     output [`SIG_LINKRATE_W-1:0]   CONFIG_LINK_RATE, 
     output [`SIG_MAXREAD_W-1:0]    CONFIG_MAX_READ_REQUEST_SIZE, 
     output [`SIG_MAXPAYLOAD_W-1:0] CONFIG_MAX_PAYLOAD_SIZE, 
     output                         CONFIG_INTERRUPT_MSIENABLE, 
     output                         CONFIG_CPL_BOUNDARY_SEL, 
     output [`SIG_FC_CPLD_W-1:0]    CONFIG_MAX_CPL_DATA, 
     output [`SIG_FC_CPLH_W-1:0]    CONFIG_MAX_CPL_HDR, 
     output                         INTR_MSI_RDY, 
     input                          INTR_MSI_REQUEST 
     );
    localparam C_ALTERA_TX_READY_LATENCY = 1; 
    localparam C_OFFSET_WIDTH  = clog2s(C_PCI_DATA_WIDTH/32); 
    reg [C_PCI_DATA_WIDTH-1:0]      rRxStData; 
    reg                             rRxStValid; 
    reg                             rRxStEop; 
    reg                             rRxStSop; 
    reg [`SIG_CFG_ADD_W-1:0]        rTlCfgAdd,_rTlCfgAdd; 
    reg [`SIG_CFG_CTL_W-1:0]        rTlCfgCtl,_rTlCfgCtl; 
    reg [`SIG_CFG_STS_W-1:0]        rTlCfgSts,_rTlCfgSts; 
    reg [`SIG_CPLID_W-1:0]          rCfgCompleterId; 
    reg                             rCfgBusMstrEnable; 
    reg [`SIG_MAXREAD_W-1:0]        rCfgMaxReadRequestSize; 
    reg [`SIG_MAXPAYLOAD_W-1:0]     rCfgMaxPayloadSize; 
    reg                             rCfgInterruptMsienable; 
    reg                             rReadCompletionBoundarySel; 
    reg [C_ALTERA_TX_READY_LATENCY-1:0] rTxStReady, _rTxStReady; 
    assign RX_ST_READY = RX_TLP_READY; 
    assign RX_TLP = RX_ST_DATA; 
    assign RX_TLP_VALID = RX_ST_VALID; 
    assign RX_TLP_END_FLAG = RX_ST_EOP; 
    assign RX_TLP_END_OFFSET = {3'b000,RX_ST_EMPTY}; 
    assign RX_TLP_START_FLAG = RX_ST_SOP; 
    assign RX_TLP_START_OFFSET = 0; 
    assign TX_TLP_READY = rTxStReady[C_ALTERA_TX_READY_LATENCY-1]; 
    assign TX_ST_DATA = TX_TLP; 
    assign TX_ST_VALID = TX_TLP_VALID & TX_TLP_READY; 
    assign TX_ST_EOP = TX_TLP_END_FLAG; 
    assign TX_ST_SOP = TX_TLP_START_FLAG; 
    assign CONFIG_COMPLETER_ID = rCfgCompleterId; 
    assign CONFIG_BUS_MASTER_ENABLE = rCfgBusMstrEnable; 
    assign CONFIG_LINK_WIDTH = rTlCfgSts[`TLSTS_LWIDTH_R]; 
    assign CONFIG_LINK_RATE = rTlCfgSts[`TLSTS_LRATE_R]; 
    assign CONFIG_MAX_READ_REQUEST_SIZE = rCfgMaxReadRequestSize; 
    assign CONFIG_MAX_PAYLOAD_SIZE = rCfgMaxPayloadSize; 
    assign CONFIG_INTERRUPT_MSIENABLE = rCfgInterruptMsienable; 
    assign CONFIG_CPL_BOUNDARY_SEL = rReadCompletionBoundarySel; 
    assign CONFIG_MAX_CPL_HDR = KO_CPL_SPC_HEADER; 
    assign CONFIG_MAX_CPL_DATA = KO_CPL_SPC_DATA; 
    assign APP_MSI_REQ = INTR_MSI_REQUEST; 
    assign INTR_MSI_RDY = APP_MSI_ACK; 
    always @(*) begin
        _rTxStReady = (rTxStReady << 1) | TX_ST_READY; 
    end
    always @(posedge CLK) begin
        rTxStReady <= _rTxStReady; 
    end
    always @(*) begin
        _rTlCfgCtl = TL_CFG_CTL; 
        _rTlCfgAdd = TL_CFG_ADD; 
        _rTlCfgSts = TL_CFG_STS; 
    end
    always @(posedge CLK) begin 
        rTlCfgAdd <= _rTlCfgAdd; 
        rTlCfgCtl <= _rTlCfgCtl; 
        rTlCfgSts <= _rTlCfgSts; 
        if(rTlCfgAdd == `TLCFG_DEVCTL_I) begin
            rCfgMaxReadRequestSize <= rTlCfgCtl[`TLCTL_MAXREQ_R]; 
            rCfgMaxPayloadSize <= rTlCfgCtl[`TLCTL_MAXPAY_R]; 
        end
        if(rTlCfgAdd == `TLCFG_LNKCTL_I) begin
            rReadCompletionBoundarySel <= rTlCfgCtl[`TLCTL_RCB_R]; 
        end
        if(rTlCfgAdd == `TLCFG_PRMCMD_I) begin
            rCfgBusMstrEnable <= rTlCfgCtl[`TLCTL_BUSMSTR_R]; 
        end
        if(rTlCfgAdd == `TLCFG_MSICSR_I) begin
            rCfgInterruptMsienable <= rTlCfgCtl[`TLCTL_MSIENABLE_R]; 
        end
        if(rTlCfgAdd == `TLCFG_BUSDEV_I) begin
            rCfgCompleterId <= {rTlCfgCtl[`TLCTL_BUSDEV_R],3'b0}; 
        end
    end 
    generate
        if (C_PCI_DATA_WIDTH == 9'd32) begin : a32
        end else if (C_PCI_DATA_WIDTH == 9'd64) begin : a64
            assign TX_ST_EMPTY = 0; 
        end else if (C_PCI_DATA_WIDTH == 9'd128) begin : a128
            assign TX_ST_EMPTY = ~TX_TLP_END_OFFSET[1] & TX_ST_EOP; 
        end else if (C_PCI_DATA_WIDTH == 9'd256) begin : a256
            assign TX_ST_EMPTY = TX_TLP_END_OFFSET[2]; 
        end
    endgenerate
endmodule 