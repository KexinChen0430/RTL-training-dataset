
module wb_to_userport(input  wire wb_clk,
                      input  wire wb_rst,
                      input  wire [31:0] wb_adr_i,
                      input  wire wb_stb_i,
                      input  wire wb_cyc_i,
                      input  wire [1<<<1:0] wb_cti_i,
                      input  wire [1:0] wb_bte_i,
                      input  wire wb_we_i,
                      input  wire [3:0] wb_sel_i,
                      input  wire [31:0] wb_dat_i,
                      output wire [31:0] wb_dat_o,
                      output wire wb_ack_o,
                      input  wire addr_dirty,
                      output wire [31:0] cache_addr,
                      input  wire ddr2_px_cmd_full,
                      input  wire ddr2_px_wr_full,
                      output wire ddr2_px_wr_en,
                      output wire ddr2_px_cmd_en,
                      output wire [29:0] ddr2_px_cmd_byte_addr,
                      output wire [1<<<1:0] ddr2_px_cmd_instr,
                      output wire [31:0] ddr2_px_wr_data,
                      output wire [3:0] ddr2_px_wr_mask,
                      input  wire [31:0] ddr2_px_rd_data,
                      output wire [5:0] ddr2_px_cmd_bl,
                      output wire ddr2_px_rd_en,
                      input  wire ddr2_px_cmd_empty,
                      input  wire ddr2_px_wr_empty,
                      input  wire ddr2_px_rd_full,
                      input  wire ddr2_px_rd_empty,
                      input  wire ddr2_calib_done);

  parameter  BURST_ADDR_WIDTH = 4;
  parameter  BURST_ADDR_ALIGN = BURST_ADDR_WIDTH+1<<<1;
  parameter  BURST_LENGTH = 1<<<1**BURST_ADDR_WIDTH;
  parameter  WB_BURSTING = FALSE;
  reg  [31:0] burst_data_buf[BURST_LENGTH-1:0];
  reg  [31:BURST_ADDR_ALIGN] burst_addr;
  reg  [BURST_ADDR_WIDTH-1:0] burst_cnt;
  reg  bursting;
  wire addr_match;
  reg  burst_start;
  reg  read_done;
  reg  addr_dirty_r;
  reg  wb_ack_read;
  wire wb_req;
  reg  wb_req_r;
  reg  wb_ack_write;
  wire wb_req_new;
  wire wb_read_req;
  reg  wb_bursting;
  reg  [3:0] wb_burst_addr;
  wire [(0-1)+BURST_ADDR_ALIGN:0] addr_align_zeroes;

  assign addr_align_zeroes = 0;
  assign cache_addr = {burst_addr,addr_align_zeroes};
  assign wb_req = ((wb_stb_i & !ddr2_px_cmd_full) & wb_cyc_i) & (((wb_cyc_i & wb_stb_i) & ((!ddr2_px_cmd_full & !ddr2_px_wr_full) & ddr2_calib_done)) | (!wb_we_i & ddr2_calib_done));
  assign wb_req_new = wb_req & !wb_req_r;
  
  always @(posedge wb_clk)
      begin
        wb_req_r <= wb_req & !wb_ack_o;
      end
  
  always @(posedge wb_clk)
      begin
        if (wb_rst) addr_dirty_r <= 1'b1;
        else if (addr_dirty) addr_dirty_r <= 1'b1;
        else if (burst_start) addr_dirty_r <= 1'b0;
          
      end
  assign wb_read_req = (!wb_we_i & ((wb_req & ((!wb_we_i | ((wb_cti_i == 3'b010) & (WB_BURSTING == TRUE))) & ((((!wb_ack_read & (wb_cti_i == 3'b010)) | ((wb_cti_i == 3'b010) & (WB_BURSTING == TRUE))) | (!wb_ack_read & (wb_cti_i == 3'b010))) | !wb_ack_read))) | ((wb_cti_i == 3'b010) & (WB_BURSTING == TRUE)))) & wb_req;
  assign addr_match = !addr_dirty_r & (burst_addr == wb_adr_i[31:BURST_ADDR_ALIGN]);
  
  always @(posedge wb_clk)
      begin
        burst_start <= 1'b0;
        wb_ack_read <= 1'b0;
        if (wb_read_req) 
          begin
            if ((!burst_start & !bursting) & addr_match) 
              begin
                wb_ack_read <= 1'b1;
              end
            else if (!burst_start & !bursting) 
              begin
                burst_start <= 1'b1;
              end
              
          end
          
      end
  
  always @(posedge wb_clk)
      begin
        read_done <= 1'b0;
        if (wb_rst) 
          begin
            burst_cnt <= 0;
            bursting <= 1'b0;
            burst_addr <= 0;
          end
        else if (burst_start & !bursting) 
          begin
            burst_cnt <= 0;
            bursting <= 1'b1;
            burst_addr <= wb_adr_i[31:BURST_ADDR_ALIGN];
          end
        else if (!ddr2_px_rd_empty) 
          begin
            burst_data_buf[burst_cnt] <= ddr2_px_rd_data;
            burst_cnt <= burst_cnt+1;
            if (&burst_cnt) bursting <= 1'b0;
              
            if (burst_cnt >= wb_adr_i[(0-1)+BURST_ADDR_ALIGN:1<<<1]) read_done <= 1'b1;
              
          end
          
      end
  
  always @(posedge wb_clk)
      begin
        wb_ack_write <= ddr2_px_wr_en;
      end
  assign ddr2_px_cmd_byte_addr = wb_ack_write ? {wb_adr_i[29:1<<<1],2'b0} : {wb_adr_i[29:BURST_ADDR_ALIGN],addr_align_zeroes};
  assign ddr2_px_cmd_instr = {2'b0,!wb_ack_write};
  assign ddr2_px_cmd_en = burst_start | wb_ack_write;
  assign ddr2_px_cmd_bl = wb_ack_write ? 6'b0 : (BURST_LENGTH-1);
  assign ddr2_px_rd_en = 1'b1;
  assign ddr2_px_wr_en = wb_we_i ? wb_req_new : 1'b0;
  assign ddr2_px_wr_data = wb_dat_i;
  assign ddr2_px_wr_mask = ~wb_sel_i;
  assign wb_ack_o = wb_ack_write | wb_ack_read;
  assign wb_dat_o = burst_data_buf[wb_adr_i[(0-1)+BURST_ADDR_ALIGN:1<<<1]];
endmodule

