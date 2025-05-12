module DeepGATE_top(
    input clk100MHz,
    output wire [13:0] led,
    input       RaspberrySPI_SS,
    input       RaspberrySPI_SCLK,
    input       RaspberrySPI_MOSI,
    output      RaspberrySPI_MISO,
    output sdram_clk,
    output sdram_cle,
    output sdram_dqm,
    output sdram_cs,
    output sdram_we,
    output sdram_cas,
    output sdram_ras,
    output [1:0] sdram_ba,
    output [12:0] sdram_a,
    inout [7:0] sdram_dq
);
`include "networkParam_include_sim.v"
wire rst = 0;
wire clk;
assign clk = clk100MHz;
wire newSPIData;
wire spiBusy;
wire [7:0] byteRX;
wire [7:0] byteTX;
wire newTXSPIData;
spiSlave spiSlave(
    .clk            (clk),
    .SS             (RaspberrySPI_SS),
    .SCLK           (RaspberrySPI_SCLK),
    .MOSI           (RaspberrySPI_MOSI),
    .MISO           (RaspberrySPI_MISO),
    .byteTX         (byteTX),
    .byteRX         (byteRX),
    .newSPIData     (newSPIData),
    .busy           (spiBusy),
    .newTXData      (newTXSPIData)
);
wire [31:0] sdramDataTX;
wire [31:0] sdramDataRX;
wire [22:0] sdramAddr;
wire sdramBusy;
wire sdramTXValid;
wire sdramRXValid;
wire sdramRW;
sdram SDRAM (
    .clk            (clk),
    .rst            (rst),
    .sdram_clk      (sdram_clk),
    .sdram_cle      (sdram_cle),
    .sdram_cs       (sdram_cs),
    .sdram_cas      (sdram_cas),
    .sdram_ras      (sdram_ras),
    .sdram_we       (sdram_we),
    .sdram_dqm      (sdram_dqm),
    .sdram_ba       (sdram_ba),
    .sdram_a        (sdram_a),
    .sdram_dq       (sdram_dq),
    .addr           (sdramAddr),      
    .rw             (sdramRW),        
    .data_in        (sdramDataTX),    
    .data_out       (sdramDataRX),    
    .busy           (sdramBusy),      
    .in_valid       (sdramTXValid),   
    .out_valid      (sdramRXValid)    
);
wire procBegin;
wire procComplete;
wire [7:0] networkDataIn;
wire [7:0] networkOut;
wire networkIdle;
wire networkRead;
wire inputRead;
wire [7:0] weightData;
wire [NUM_TILES - 1'b1 : 0] pipelineLock;
wire [NUM_TILES - 1'b1 : 0] weightRAMwrEn;
tile_network ANN(
    .clk_i              (clk),
    .en_i               (procBegin),
    .data_rd_o          (inputRead),
    .data_rd_i          (networkRead),
    .data_i             (networkDataIn),
    .network_idle_o     (networkIdle),
    .data_o             (networkOut),
    .proc_complete_o    (procComplete),
    .weight_wr_i        (weightRAMwrEn),
    .weight_data_i      (weightData),
    .pipeline_lock_o    (pipelineLock)
);
wire [7:0] MCUled;
masterControl MCU(
    .clk                (clk),
    .rst                (rst),
    .TXBusy             (spiBusy),
    .newRXData          (newSPIData),
    .RXData             (byteRX),
    .TXDataBuffer       (byteTX),
    .newTXData          (newTXSPIData),
    .inputRead          (inputRead),
    .networkIdle        (networkIdle),
    .procComplete       (procComplete),
    .networkOut         (networkOut),
    .networkDataIn      (networkDataIn),
    .procBegin          (procBegin),
    .networkRead        (networkRead),
    .weightRAMwrEn      (weightRAMwrEn),
    .weightDataOut      (weightData),
    .pipelineLock       (pipelineLock),
    .sdramBusy          (sdramBusy),
    .sdramRXValid       (sdramRXValid),
    .sdramDataRX        (sdramDataRX),
    .sdramDataTX        (sdramDataTX),
    .sdramAddr          (sdramAddr),
    .sdramTXValid       (sdramTXValid),
    .sdramRW            (sdramRW),
    .LED                (MCUled)
);
assign led[13:8] = 0;
assign led[7:0] = MCUled;
endmodule