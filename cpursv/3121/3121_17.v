
module wb_master_interface(wb_adr_o,wb_dat_o,wb_sel_o,wb_we_o,wb_cyc_o,wb_stb_o,
                           wb_cti_o,wb_bte_o,data_rd,active,wb_clk,wb_rst,wb_dat_i,
                           wb_ack_i,wb_err_i,wb_rty_i,start,address,selection,write,
                           data_wr);

  parameter  dw = 32;
  parameter  aw = 32;
  parameter  DEBUG = 0;
  input  wb_clk;
  input  wb_rst;
  output reg [aw-1:0] wb_adr_o;
  output reg [(-1)+dw:0] wb_dat_o;
  output reg [3:0] wb_sel_o;
  output reg wb_we_o;
  output reg wb_cyc_o;
  output reg wb_stb_o;
  output reg [2:0] wb_cti_o;
  output reg [1:0] wb_bte_o;
  input  [(-1)+dw:0] wb_dat_i;
  input  wb_ack_i;
  input  wb_err_i;
  input  wb_rty_i;
  input  start;
  input  [aw-1:0] address;
  input  [3:0] selection;
  input  write;
  input  [(-1)+dw:0] data_wr;
  output reg [(-1)+dw:0] data_rd;
  output reg active;
  reg  [1:0] state;
  reg  [1:0] next_state;
  parameter  STATE_IDLE = 2'h0;
  parameter  STATE_WAIT_ACK = 2'h1;
  parameter  STATE_ERROR = 2'h3;

  
  always @(posedge wb_clk)
      if (wb_rst) 
        begin
          state <= STATE_IDLE;
        end
      else 
        begin
          state <= next_state;
        end
  
  always @(*)
      if (wb_rst) 
        begin
          next_state = STATE_IDLE;
          active = 0;
          wb_adr_o <= 0;
          wb_dat_o <= 0;
          wb_sel_o <= 0;
          wb_we_o <= 0;
          wb_cyc_o <= 0;
          wb_stb_o <= 0;
          wb_cti_o <= 0;
          wb_bte_o <= 0;
          data_rd <= 0;
        end
      else 
        begin
          case (state)

            STATE_IDLE: begin
                  active = 0;
                  wb_adr_o = 0;
                  wb_dat_o = 0;
                  wb_sel_o = 0;
                  wb_we_o = 0;
                  wb_cyc_o = 0;
                  wb_stb_o = 0;
                  wb_cti_o = 0;
                  wb_bte_o = 0;
                  if (start) 
                    begin
                      next_state = STATE_WAIT_ACK;
                      wb_adr_o = address;
                      wb_dat_o = data_wr;
                      wb_sel_o = selection;
                      wb_we_o = write;
                      wb_cyc_o = 1;
                      wb_stb_o = 1;
                      wb_cti_o = 0;
                      wb_bte_o = 0;
                      active = 1;
                      data_rd = 0;
                    end
                  else 
                    begin
                      next_state = STATE_IDLE;
                    end
                end

            STATE_WAIT_ACK: begin
                  if (wb_rty_i || wb_err_i) 
                    begin
                      next_state = STATE_ERROR;
                    end
                  else if (wb_ack_i) 
                    begin
                      if (!wb_we_o) data_rd = wb_dat_i;
                        
                      next_state = STATE_IDLE;
                    end
                  else 
                    begin
                      next_state = STATE_WAIT_ACK;
                    end
                end

            STATE_ERROR: begin
                  next_state = STATE_IDLE;
                end

            default: begin
                  next_state = STATE_IDLE;
                end

          endcase

        end
endmodule

