
module wb_to_userport(input  wire wb_clk,
                      input  wire wb_rst,
                      input  wire [31:0] wb_adr_i,
                      input  wire wb_stb_i,
                      input  wire wb_cyc_i,
                      input  wire [2:0] wb_cti_i,
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
                      output wire [2:0] ddr2_px_cmd_instr,
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
  parameter  BURST_ADDR_ALIGN = 1+(1+BURST_ADDR_WIDTH);
  parameter  BURST_LENGTH = 2**BURST_ADDR_WIDTH;
  parameter  WB_BURSTING = FALSE;
  reg  [31:0] burst_data_buf[(0-1)+BURST_LENGTH:0];
  reg  [31:BURST_ADDR_ALIGN] burst_addr;
  reg  [(0-1)+BURST_ADDR_WIDTH:0] burst_cnt;
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
  wire [BURST_ADDR_ALIGN-1:0] addr_align_zeroes;

  assign addr_align_zeroes = 0;
  assign cache_addr = {burst_addr,addr_align_zeroes};
  assign wb_req = ((!wb_we_i | (((!ddr2_px_wr_full & !ddr2_px_cmd_full) & ddr2_calib_done) & wb_stb_i)) & (wb_cyc_i | !wb_we_i)) & (((wb_stb_i & ddr2_calib_done) & !ddr2_px_cmd_full) & wb_cyc_i);
  assign wb_req_new = !wb_req_r & wb_req;
  
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
  assign wb_read_req = (!wb_we_i & (wb_req & !wb_ack_read)) | (!wb_we_i & (wb_req & ((WB_BURSTING == TRUE) & (wb_cti_i == 3'b010))));
  assign addr_match = (burst_addr == wb_adr_i[31:BURST_ADDR_ALIGN]) & !addr_dirty_r;
  
  always @(posedge wb_clk)
      begin
        burst_start <= 1'b0;
        wb_ack_read <= 1'b0;
        if (wb_read_req) 
          begin
            if (addr_match & (!bursting & !burst_start)) 
              begin
                wb_ack_read <= 1'b1;
              end
            else if (!bursting & !burst_start) 
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
        else if (!bursting & burst_start) 
          begin
            burst_cnt <= 0;
            bursting <= 1'b1;
            burst_addr <= wb_adr_i[31:BURST_ADDR_ALIGN];
          end
        else if (!ddr2_px_rd_empty) 
          begin
            burst_data_buf[burst_cnt] <= ddr2_px_rd_data;
            burst_cnt <= 1+burst_cnt;
            if (&burst_cnt) bursting <= 1'b0;
              
            if (burst_cnt >= wb_adr_i[BURST_ADDR_ALIGN-1:2]) read_done <= 1'b1;
              
          end
          
      end
  
  always @(posedge wb_clk)
      begin
        wb_ack_write <= ddr2_px_wr_en;
      end
  assign ddr2_px_cmd_byte_addr = wb_ack_write ? {wb_adr_i[29:2],2'b0} : {wb_adr_i[29:BURST_ADDR_ALIGN],addr_align_zeroes};
  assign ddr2_px_cmd_instr = {2'b0,!wb_ack_write};
  assign ddr2_px_cmd_en = wb_ack_write | burst_start;
  assign ddr2_px_cmd_bl = wb_ack_write ? 6'b0 : ((0-1)+BURST_LENGTH);
  assign ddr2_px_rd_en = 1'b1;
  assign ddr2_px_wr_en = wb_we_i ? wb_req_new : 1'b0;
  assign ddr2_px_wr_data = wb_dat_i;
  assign ddr2_px_wr_mask = ~wb_sel_i;
  assign wb_ack_o = wb_ack_read | wb_ack_write;
  assign wb_dat_o = burst_data_buf[wb_adr_i[BURST_ADDR_ALIGN-1:2]];
endmodule

