
module ui_cmd  #(parameter 
       TCQ            = 100,
       ADDR_WIDTH     = 33,
       BANK_WIDTH     = 3,
       COL_WIDTH      = 12,
       RANK_WIDTH     = 1<<<1,
       ROW_WIDTH      = 16,
       RANKS          = 4,
       MEM_ADDR_ORDER = BANK_ROW_COLUMN)
  (app_rdy,use_addr,rank,bank,row,col,size,cmd,hi_priority,
              rd_accepted,wr_accepted,data_buf_addr,rst,clk,accept_ns,
              rd_buf_full,wr_req_16,app_addr,app_cmd,app_sz,app_hi_pri,
              app_en,wr_data_buf_addr,rd_data_buf_addr_r);

  input  rst;
  input  clk;
  input  accept_ns;
  input  rd_buf_full;
  input  wr_req_16;
  wire 
       app_rdy_ns = ~rd_buf_full && accept_ns && ~wr_req_16;
  reg  app_rdy_r;

  
  always @(posedge clk)
      app_rdy_r <= #TCQ app_rdy_ns;
  output wire app_rdy;

  assign app_rdy = app_rdy_r;
  input  [ADDR_WIDTH+(0-1):0] app_addr;

  input  [1<<<1:0] app_cmd;

  input  app_sz;

  input  app_hi_pri;

  input  app_en;

  reg  [ADDR_WIDTH+(0-1):0] app_addr_r1,app_addr_r2;

  reg  [1<<<1:0] app_cmd_r1,app_cmd_r2;

  reg  app_sz_r1,app_sz_r2;

  reg  app_hi_pri_r1,app_hi_pri_r2;

  reg  app_en_r1,app_en_r2;

  wire [ADDR_WIDTH+(0-1):0]  app_addr_ns1 = app_rdy_r ? app_addr : app_addr_r1;

  wire [ADDR_WIDTH+(0-1):0] 
       app_addr_ns2 = app_rdy_r ? app_addr_r1 : app_addr_r2;

  wire [1<<<1:0]  app_cmd_ns1 = app_rdy_r ? app_cmd : app_cmd_r1;

  wire [1<<<1:0]  app_cmd_ns2 = app_rdy_r ? app_cmd_r1 : app_cmd_r2;

  wire  app_sz_ns1 = app_rdy_r ? app_sz : app_sz_r1;

  wire  app_sz_ns2 = app_rdy_r ? app_sz_r1 : app_sz_r2;

  wire 
       app_hi_pri_ns1 = app_rdy_r ? app_hi_pri : app_hi_pri_r1;

  wire 
       app_hi_pri_ns2 = app_rdy_r ? app_hi_pri_r1 : app_hi_pri_r2;

  wire 
       app_en_ns1 = ~rst && (app_rdy_r ? app_en : app_en_r1);

  wire 
       app_en_ns2 = ~rst && (app_rdy_r ? app_en_r1 : app_en_r2);

  
  always @(posedge clk)
      begin
        app_addr_r1 <= #TCQ app_addr_ns1;
        app_addr_r2 <= #TCQ app_addr_ns2;
        app_cmd_r1 <= #TCQ app_cmd_ns1;
        app_cmd_r2 <= #TCQ app_cmd_ns2;
        app_sz_r1 <= #TCQ app_sz_ns1;
        app_sz_r2 <= #TCQ app_sz_ns2;
        app_hi_pri_r1 <= #TCQ app_hi_pri_ns1;
        app_hi_pri_r2 <= #TCQ app_hi_pri_ns2;
        app_en_r1 <= #TCQ app_en_ns1;
        app_en_r2 <= #TCQ app_en_ns2;
      end
  wire  use_addr_lcl = app_rdy_r && app_en_r2;

  output wire use_addr;

  assign use_addr = use_addr_lcl;
  output wire [RANK_WIDTH+(0-1):0] rank;

  output wire [(0-1)+BANK_WIDTH:0] bank;

  output wire [(0-1)+ROW_WIDTH:0] row;

  output wire [(0-1)+COL_WIDTH:0] col;

  output wire size;

  output wire [1<<<1:0] cmd;

  output wire hi_priority;

  assign col = app_rdy_r ? app_addr_r1[0 +: COL_WIDTH] : app_addr_r2[0 +: COL_WIDTH];
  
  generate
      begin
        if (MEM_ADDR_ORDER == ROW_BANK_COLUMN) 
          begin
            assign row = app_rdy_r ? app_addr_r1[COL_WIDTH+BANK_WIDTH +: ROW_WIDTH] : app_addr_r2[COL_WIDTH+BANK_WIDTH +: ROW_WIDTH];
            assign bank = app_rdy_r ? app_addr_r1[COL_WIDTH +: BANK_WIDTH] : app_addr_r2[COL_WIDTH +: BANK_WIDTH];
          end
        else 
          begin
            assign row = app_rdy_r ? app_addr_r1[COL_WIDTH +: ROW_WIDTH] : app_addr_r2[COL_WIDTH +: ROW_WIDTH];
            assign bank = app_rdy_r ? app_addr_r1[ROW_WIDTH+COL_WIDTH +: BANK_WIDTH] : app_addr_r2[ROW_WIDTH+COL_WIDTH +: BANK_WIDTH];
          end
      end
  endgenerate

  assign rank = (RANKS == 1) ? 1'b0 : 
                app_rdy_r ? app_addr_r1[COL_WIDTH+(ROW_WIDTH+BANK_WIDTH) +: RANK_WIDTH] : app_addr_r2[COL_WIDTH+(ROW_WIDTH+BANK_WIDTH) +: RANK_WIDTH];
  assign size = app_rdy_r ? app_sz_r1 : app_sz_r2;
  assign cmd = app_rdy_r ? app_cmd_r1 : app_cmd_r2;
  assign hi_priority = app_rdy_r ? app_hi_pri_r1 : app_hi_pri_r2;
  wire  request_accepted = use_addr_lcl && app_rdy_r;

  wire  rd = app_cmd_r2[1:0] == 2'b01;

  wire  wr = app_cmd_r2[1:0] == 2'b00;

  wire  wr_bytes = app_cmd_r2[1:0] == 2'b11;

  wire  write = wr_bytes || wr;

  output wire rd_accepted;

  assign rd_accepted = rd && request_accepted;
  output wire wr_accepted;

  assign wr_accepted = request_accepted && write;
  input  [3:0] wr_data_buf_addr;

  input  [3:0] rd_data_buf_addr_r;

  output wire [3:0] data_buf_addr;

  assign data_buf_addr = ~write ? rd_data_buf_addr_r : wr_data_buf_addr;
endmodule

