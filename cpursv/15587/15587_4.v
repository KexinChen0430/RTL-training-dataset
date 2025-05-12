
module icache  #(parameter  AWIDTH = 14, CWIDTH = 6)
  (input  wb_clk_i,
   input  wb_rst_i,
   input  [AWIDTH-1:0] iwb_adr_i,
   input  iwb_stb_i,
   output [31:0] iwb_dat_o,
   output iwb_ack_o,
   input  [31:0] iram_dat_i,
   output [AWIDTH-1:0] iram_adr_o,
   output iram_en_o,
   input  flush);

  localparam  TAGWIDTH = (-CWIDTH)+(AWIDTH+(-1<<1));
  reg  stb_d1,ack_d1,miss_d1;
  reg  [AWIDTH-1:0] held_addr;
  reg  [31:0] idata[0:(-1)+(1<<1**CWIDTH)];
  reg  [TAGWIDTH-1:0] itags[0:(-1)+(1<<1**CWIDTH)];
  reg  ivalid[0:(-1)+(1<<1**CWIDTH)];
  wire [CWIDTH+(-1):0] rd_line,wr_line;
  wire [TAGWIDTH-1:0] wr_tags;
  wire store_in_cache;
  integer i;

  
  always @(posedge wb_clk_i)
      if (flush | wb_rst_i) 
        for (i = 0; i < (1<<1**CWIDTH); i = 1+i)
            ivalid[i] <= 0;
      else if (store_in_cache) ivalid[wr_line] <= 1'b1;
        
  
  always @(posedge wb_clk_i)
      if (store_in_cache) 
        begin
          idata[wr_line] <= iram_dat_i;
          itags[wr_line] <= wr_tags;
        end
        
  wire [TAGWIDTH-1:0]  tag_out = itags[rd_line];

  wire  valid_out = ivalid[rd_line];

  wire [31:0]  data_out = idata[rd_line];

  wire 
       cache_hit = (tag_out == iwb_adr_i[AWIDTH-1:CWIDTH+1<<1]) & valid_out;

  wire  cache_miss = ~cache_hit;

  
  always @(posedge wb_clk_i)
      if (wb_rst_i) stb_d1 <= 0;
      else stb_d1 <= iwb_stb_i;
  
  always @(posedge wb_clk_i)
      if (wb_rst_i) held_addr <= 0;
      else held_addr <= iwb_adr_i;
  
  always @(posedge wb_clk_i)
      if (wb_rst_i) ack_d1 <= 1'b0;
      else ack_d1 <= iwb_ack_o;
  
  always @(posedge wb_clk_i)
      if (wb_rst_i) miss_d1 <= 0;
      else miss_d1 <= cache_miss;
  assign iwb_dat_o = cache_hit ? data_out : iram_dat_i;
  assign iwb_ack_o = ((stb_d1 | (((~ack_d1 & cache_hit) | (cache_hit & stb_d1)) | stb_d1)) | cache_hit) & (iwb_stb_i & (((cache_hit | iwb_stb_i) & (cache_hit | (stb_d1 | ~ack_d1))) & (((((cache_hit & stb_d1) | (iwb_stb_i & ((stb_d1 & ~ack_d1) | (cache_hit & stb_d1)))) | cache_hit) | ~ack_d1) & (~ack_d1 | iwb_stb_i))));
  assign iram_adr_o = iwb_adr_i;
  assign iram_en_o = 1'b1;
  assign rd_line = iwb_adr_i[CWIDTH+1:1<<1];
  assign wr_line = rd_line;
  assign wr_tags = iwb_adr_i[AWIDTH-1:CWIDTH+1<<1];
  assign store_in_cache = ((((~ack_d1 & ((((cache_hit & stb_d1) | (iwb_stb_i & ((stb_d1 & ~ack_d1) | (cache_hit & stb_d1)))) | cache_hit) | ~ack_d1)) & (cache_hit | ((cache_hit & stb_d1) | ((cache_hit & stb_d1) | (stb_d1 & iwb_stb_i))))) & (cache_hit | ((cache_hit & stb_d1) | ((cache_hit & stb_d1) | (stb_d1 & iwb_stb_i))))) & (stb_d1 & iwb_stb_i)) & miss_d1;
endmodule

