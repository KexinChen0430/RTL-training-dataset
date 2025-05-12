module fifo_generator_v13_2_4_beh_ver_ll_afifo
  /***************************************************************************
  #(
    parameter  C_DIN_WIDTH                    = 8,  
    parameter  C_DOUT_RST_VAL                 = "", 
    parameter  C_DOUT_WIDTH                   = 8,  
    parameter  C_FULL_FLAGS_RST_VAL           = 1,  
    parameter  C_HAS_RD_DATA_COUNT            = 0,  
    parameter  C_HAS_WR_DATA_COUNT            = 0,  
    parameter  C_RD_DEPTH                     = 256,
    parameter  C_RD_PNTR_WIDTH                = 8,  
    parameter  C_USE_DOUT_RST                 = 0,  
    parameter  C_WR_DATA_COUNT_WIDTH          = 2,  
    parameter  C_WR_DEPTH                     = 256,
    parameter  C_WR_PNTR_WIDTH                = 8,  
    parameter  C_FIFO_TYPE                    = 0   
   )
  /***************************************************************************
  (
   input       [C_DIN_WIDTH-1:0]                 DIN,        
   input                                         RD_CLK,     
   input                                         RD_EN,      
   input                                         WR_RST,     
   input                                         RD_RST,     
   input                                         WR_CLK,     
   input                                         WR_EN,      
   output reg  [C_DOUT_WIDTH-1:0]                DOUT = 0,   
   output reg                                    EMPTY = 1'b1,
   output reg                                    FULL = C_FULL_FLAGS_RST_VAL 
  );
  reg [C_DIN_WIDTH-1:0] memory[C_WR_DEPTH-1:0]; 
  integer i; 
  initial begin
    for (i = 0; i < C_WR_DEPTH; i = i + 1)
      memory[i] = 0;
  end
  reg  [C_WR_PNTR_WIDTH-1:0] wr_pntr_ll_afifo = 0; 
  wire [C_RD_PNTR_WIDTH-1:0] rd_pntr_ll_afifo;     
  reg  [C_RD_PNTR_WIDTH-1:0] rd_pntr_ll_afifo_q = 0; 
  reg                        ll_afifo_full    = 1'b0; 
  reg                        ll_afifo_empty   = 1'b1; 
  wire                       write_allow; 
  wire                       read_allow;  
  assign write_allow = WR_EN & ~ll_afifo_full;
  assign read_allow  = RD_EN & ~ll_afifo_empty;
  always @(posedge WR_CLK or posedge WR_RST) begin
    if (WR_RST)
      wr_pntr_ll_afifo   <= 0; 
    else if (write_allow)
      wr_pntr_ll_afifo <= #`TCQ wr_pntr_ll_afifo + 1; 
  end
  always @(posedge RD_CLK or posedge RD_RST) begin
    if (RD_RST)
      rd_pntr_ll_afifo_q   <= 0; 
    else
      rd_pntr_ll_afifo_q <= #`TCQ rd_pntr_ll_afifo; 
  end
  assign rd_pntr_ll_afifo = read_allow ? rd_pntr_ll_afifo_q + 1 : rd_pntr_ll_afifo_q;
  always @(posedge WR_CLK) begin
    if (write_allow)
      memory[wr_pntr_ll_afifo] <= #`TCQ DIN; 
  end
  always @(posedge RD_CLK) begin
      DOUT <= #`TCQ memory[rd_pntr_ll_afifo]; 
  end
  always @(posedge RD_CLK or posedge RD_RST) begin
    if (RD_RST)
      ll_afifo_empty   <= 1'b1; 
    else
      ll_afifo_empty   <= ((wr_pntr_ll_afifo == rd_pntr_ll_afifo_q) |
                           (read_allow & (wr_pntr_ll_afifo == (rd_pntr_ll_afifo_q + 2'h1)))); 
  end
  always @(posedge WR_CLK or posedge WR_RST) begin
    if (WR_RST)
      ll_afifo_full   <= 1'b1; 
    else
      ll_afifo_full   <= ((rd_pntr_ll_afifo_q == (wr_pntr_ll_afifo + 2'h1)) |
                           (write_allow & (rd_pntr_ll_afifo_q == (wr_pntr_ll_afifo + 2'h2)))); 
  end
  always @* begin
    FULL  <= ll_afifo_full; 
    EMPTY <= ll_afifo_empty; 
  end
endmodule