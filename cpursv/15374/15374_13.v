
module dcache  #(parameter  AWIDTH = 14, CWIDTH = 6)
  (input  wb_clk_i,
   input  wb_rst_i,
   input  [AWIDTH+(-1):0] dwb_adr_i,
   input  dwb_stb_i,
   input  dwb_we_i,
   input  [3:0] dwb_sel_i,
   input  [31:0] dwb_dat_i,
   output [31:0] dwb_dat_o,
   output dwb_ack_o,
   input  [31:0] dram_dat_i,
   output [31:0] dram_dat_o,
   output [AWIDTH+(-1):0] dram_adr_o,
   output dram_we_o,
   output dram_en_o,
   output [3:0] dram_sel_o);

  localparam  TAGWIDTH = (0-CWIDTH)+(AWIDTH+(-2));
  reg  stb_d1,ack_d1,miss_d1;
  reg  [AWIDTH+(-1):0] held_addr;
  reg  [31:0] ddata[0:1<<CWIDTH+(-1)];
  reg  [TAGWIDTH+(-1):0] dtags[0:1<<CWIDTH+(-1)];
  reg  dvalid[0:1<<CWIDTH+(-1)];
  wire [CWIDTH-1:0] rd_line,wr_line;
  wire [TAGWIDTH+(-1):0] wr_tags;
  wire cache_write,invalidate;
  wire [31:0] wr_data;
  integer i;

  
  always @(posedge wb_clk_i)
      if (wb_rst_i) 
        for (i = 0; i < 1<<CWIDTH; i = i+1)
            dvalid[i] <= 0;
      else if (invalidate) dvalid[wr_line] <= 1'b0;
      else if (cache_write) dvalid[wr_line] <= 1'b1;
        
  
  always @(posedge wb_clk_i)
      if (cache_write) 
        begin
          ddata[wr_line] <= wr_data;
          dtags[wr_line] <= wr_tags;
        end
        
  wire [TAGWIDTH+(-1):0]  tag_out = dtags[rd_line];

  wire  valid_out = dvalid[rd_line];

  wire [31:0]  data_out = ddata[rd_line];

  wire 
       cache_hit = (tag_out == dwb_adr_i[AWIDTH+(-1):CWIDTH+2]) & valid_out;

  wire  cache_miss = ~cache_hit;

  
  always @(posedge wb_clk_i)
      if (wb_rst_i) stb_d1 <= 0;
      else stb_d1 <= dwb_stb_i;
  
  always @(posedge wb_clk_i)
      if (wb_rst_i) held_addr <= 0;
      else held_addr <= dwb_adr_i;
  
  always @(posedge wb_clk_i)
      if (wb_rst_i) ack_d1 <= 1'b0;
      else ack_d1 <= dwb_ack_o;
  
  always @(posedge wb_clk_i)
      if (wb_rst_i) miss_d1 <= 0;
      else miss_d1 <= cache_miss;
  assign dwb_dat_o = dram_dat_i;
  assign dwb_ack_o = ((stb_d1 | (((~ack_d1 | dwb_we_i) & stb_d1) | dwb_we_i)) & (((stb_d1 & ((~ack_d1 & dwb_stb_i) | dwb_we_i)) & dwb_stb_i) | dwb_we_i)) & (dwb_stb_i & ((~ack_d1 | dwb_stb_i) & (~ack_d1 | dwb_we_i)));
  assign dram_adr_o = dwb_adr_i;
  assign dram_en_o = dwb_stb_i;
  assign dram_dat_o = dwb_dat_i;
  assign dram_we_o = dwb_we_i;
  assign dram_sel_o = dwb_sel_i;
  assign rd_line = 0;
  assign wr_line = 0;
  assign wr_tags = 0;
  assign wr_data = 0;
  assign cache_write = 0;
  assign invalidate = 0;
endmodule

