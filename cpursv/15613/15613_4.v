
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
       app_rdy_ns = ~wr_req_16 && (~rd_buf_full && accept_ns);
  reg   app_rdy_r = 1'b0;

  
  always @(posedge clk)
      app_rdy_r <= #TCQ app_rdy_ns;
  reg  app_rdy_inv_r;

  
  always @(posedge clk)
      app_rdy_inv_r <= #TCQ ~app_rdy_ns;
  output wire app_rdy;

  assign app_rdy = app_rdy_r;
  input  [ADDR_WIDTH-1:0] app_addr;

  input  [1<<<1:0] app_cmd;

  input  app_sz;

  input  app_hi_pri;

  input  app_en;

  reg  [ADDR_WIDTH-1:0]  app_addr_r1 = {ADDR_WIDTH{1'b0}};

  reg  [ADDR_WIDTH-1:0]  app_addr_r2 = {ADDR_WIDTH{1'b0}};

  reg  [1<<<1:0] app_cmd_r1;

  reg  [1<<<1:0] app_cmd_r2;

  reg  app_sz_r1;

  reg  app_sz_r2;

  reg  app_hi_pri_r1;

  reg  app_hi_pri_r2;

  reg  app_en_r1;

  reg  app_en_r2;

  wire [ADDR_WIDTH-1:0] 
       app_addr_ns1 = ((app_addr & {ADDR_WIDTH{app_en}}) & {ADDR_WIDTH{app_rdy_r}}) | ((((app_addr & {ADDR_WIDTH{app_en}}) & {ADDR_WIDTH{app_rdy_r}}) & {ADDR_WIDTH{app_rdy_inv_r}}) | (app_addr_r1 & ({ADDR_WIDTH{app_rdy_inv_r}} & (({ADDR_WIDTH{app_rdy_inv_r}} | app_addr) & (app_addr | app_addr_r1)))));

  wire [ADDR_WIDTH-1:0] 
       app_addr_ns2 = ((app_addr_r1 | app_addr_r2) & (app_addr_r2 | {ADDR_WIDTH{app_rdy_r}})) & (({ADDR_WIDTH{app_rdy_inv_r}} | {ADDR_WIDTH{app_rdy_r}}) & (app_addr_r1 | {ADDR_WIDTH{app_rdy_inv_r}}));

  wire [1<<<1:0] 
       app_cmd_ns1 = ({3{app_rdy_r}} & (app_cmd & ((app_cmd_r1 | {3{app_rdy_r}}) & (app_cmd_r1 | app_cmd)))) | (((app_cmd_r1 | {3{app_rdy_r}}) & (app_cmd_r1 | app_cmd)) & {3{app_rdy_inv_r}});

  wire [1<<<1:0] 
       app_cmd_ns2 = ((app_cmd_r2 | app_cmd_r1) & (app_cmd_r1 | {3{app_rdy_inv_r}})) & ((app_cmd_r2 | {3{app_rdy_r}}) & ({3{app_rdy_inv_r}} | {3{app_rdy_r}}));

  wire 
       app_sz_ns1 = ((app_sz_r1 & ((app_sz_r1 | app_sz) & (app_rdy_inv_r | app_sz))) & app_rdy_inv_r) | (app_sz & app_rdy_r);

  wire 
       app_sz_ns2 = (app_sz_r2 | app_rdy_r) & ((app_rdy_inv_r | (app_sz_r1 & (app_rdy_r | app_rdy_inv_r))) & (app_sz_r2 | app_sz_r1));

  wire 
       app_hi_pri_ns1 = (((app_rdy_r & app_hi_pri) | app_rdy_inv_r) & app_hi_pri_r1) | (app_rdy_r & app_hi_pri);

  wire 
       app_hi_pri_ns2 = (app_hi_pri_r2 & ((app_hi_pri_r1 & app_rdy_r) | app_rdy_inv_r)) | (app_hi_pri_r1 & app_rdy_r);

  wire 
       app_en_ns1 = ~rst && 
((app_en_r1 | (app_en & app_rdy_r)) & ((app_rdy_inv_r | app_en) & (app_rdy_r | app_rdy_inv_r)));

  wire 
       app_en_ns2 = ~rst && 
((app_rdy_inv_r & app_en_r2) | (app_en_r1 & ((app_rdy_r | app_rdy_inv_r) & (app_en_r2 | app_rdy_r))));

  
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
  output wire [RANK_WIDTH+(-1):0] rank;

  output wire [(-1)+BANK_WIDTH:0] bank;

  output wire [ROW_WIDTH-1:0] row;

  output wire [COL_WIDTH-1:0] col;

  output wire size;

  output wire [1<<<1:0] cmd;

  output wire hi_priority;

  assign col = ((((app_addr_r1[0 +: COL_WIDTH] | {COL_WIDTH{app_rdy_inv_r}}) & {COL_WIDTH{app_rdy_r}}) | {COL_WIDTH{app_rdy_inv_r}}) & ({COL_WIDTH{app_rdy_r}} | app_addr_r2[0 +: COL_WIDTH])) & (app_addr_r1[0 +: COL_WIDTH] | app_addr_r2[0 +: COL_WIDTH]);
  
  generate
      begin
        if (MEM_ADDR_ORDER == ROW_BANK_COLUMN) 
          begin
            assign row = (({ROW_WIDTH{app_rdy_inv_r}} | app_addr_r1[COL_WIDTH+BANK_WIDTH +: ROW_WIDTH]) & ((app_addr_r2[COL_WIDTH+BANK_WIDTH +: ROW_WIDTH] | (({ROW_WIDTH{app_rdy_r}} & app_addr_r1[COL_WIDTH+BANK_WIDTH +: ROW_WIDTH]) & {ROW_WIDTH{app_rdy_inv_r}})) | ({ROW_WIDTH{app_rdy_r}} & app_addr_r1[COL_WIDTH+BANK_WIDTH +: ROW_WIDTH]))) & ({ROW_WIDTH{app_rdy_r}} | ({ROW_WIDTH{app_rdy_inv_r}} | ({ROW_WIDTH{app_rdy_r}} & ({ROW_WIDTH{app_rdy_inv_r}} | app_addr_r1[COL_WIDTH +: ROW_WIDTH]))));
            assign bank = (app_addr_r1[COL_WIDTH +: BANK_WIDTH] & {BANK_WIDTH{app_rdy_r}}) | ((app_addr_r2[COL_WIDTH +: BANK_WIDTH] & (app_addr_r1[COL_WIDTH +: BANK_WIDTH] & {BANK_WIDTH{app_rdy_r}})) | ({BANK_WIDTH{app_rdy_inv_r}} & app_addr_r2[COL_WIDTH +: BANK_WIDTH]));
          end
        else 
          begin
            assign row = ((app_addr_r1[COL_WIDTH +: ROW_WIDTH] & ({ROW_WIDTH{app_rdy_inv_r}} | ({ROW_WIDTH{app_rdy_r}} & ({ROW_WIDTH{app_rdy_inv_r}} | app_addr_r1[COL_WIDTH +: ROW_WIDTH])))) & {ROW_WIDTH{app_rdy_r}}) | (({ROW_WIDTH{app_rdy_r}} | ({ROW_WIDTH{app_rdy_inv_r}} | ({ROW_WIDTH{app_rdy_r}} & ({ROW_WIDTH{app_rdy_inv_r}} | app_addr_r1[COL_WIDTH +: ROW_WIDTH])))) & (app_addr_r2[COL_WIDTH +: ROW_WIDTH] & ({ROW_WIDTH{app_rdy_inv_r}} | app_addr_r1[COL_WIDTH +: ROW_WIDTH])));
            assign bank = (app_addr_r1[ROW_WIDTH+COL_WIDTH +: BANK_WIDTH] & {BANK_WIDTH{app_rdy_r}}) | (((app_addr_r2[ROW_WIDTH+COL_WIDTH +: BANK_WIDTH] & (app_addr_r1[ROW_WIDTH+COL_WIDTH +: BANK_WIDTH] & {BANK_WIDTH{app_rdy_r}})) | ({BANK_WIDTH{app_rdy_inv_r}} & app_addr_r2[ROW_WIDTH+COL_WIDTH +: BANK_WIDTH])) | ({BANK_WIDTH{app_rdy_inv_r}} & (app_addr_r1[ROW_WIDTH+COL_WIDTH +: BANK_WIDTH] & {BANK_WIDTH{app_rdy_r}})));
          end
      end
  endgenerate

  assign rank = (RANKS == 1) ? 1'b0 : (({RANK_WIDTH{app_rdy_inv_r}} | (app_addr_r1[(BANK_WIDTH+ROW_WIDTH)+COL_WIDTH +: RANK_WIDTH] & ({RANK_WIDTH{app_rdy_inv_r}} | {RANK_WIDTH{app_rdy_r}}))) & (({RANK_WIDTH{app_rdy_r}} & app_addr_r1[(BANK_WIDTH+ROW_WIDTH)+COL_WIDTH +: RANK_WIDTH]) | app_addr_r2[(BANK_WIDTH+ROW_WIDTH)+COL_WIDTH +: RANK_WIDTH]));
  assign size = (app_sz_r2 | app_rdy_r) & ((app_rdy_inv_r | (app_sz_r1 & (app_rdy_r | app_rdy_inv_r))) & (app_sz_r2 | app_sz_r1));
  assign cmd = ((app_cmd_r2 | app_cmd_r1) & (app_cmd_r1 | {3{app_rdy_inv_r}})) & ((app_cmd_r2 | {3{app_rdy_r}}) & ({3{app_rdy_inv_r}} | {3{app_rdy_r}}));
  assign hi_priority = (app_hi_pri_r2 & ((app_hi_pri_r1 & app_rdy_r) | app_rdy_inv_r)) | (app_hi_pri_r1 & app_rdy_r);
  wire  request_accepted = app_rdy_r && use_addr_lcl;

  wire  rd = app_cmd_r2[1:0] == 2'b01;

  wire  wr = app_cmd_r2[1:0] == 2'b00;

  wire  wr_bytes = app_cmd_r2[1:0] == 2'b11;

  wire  write = wr_bytes || wr;

  output wire rd_accepted;

  assign rd_accepted = request_accepted && rd;
  output wire wr_accepted;

  assign wr_accepted = write && request_accepted;
  input  [3:0] wr_data_buf_addr;

  input  [3:0] rd_data_buf_addr_r;

  output wire [3:0] data_buf_addr;

  assign data_buf_addr = ~write ? rd_data_buf_addr_r : wr_data_buf_addr;
endmodule

