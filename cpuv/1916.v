module sd_cmd_layer (
  input                     clk,
  input                     rst,
  output                    o_sd_ready,
  input                     i_crc_enable_flag,
  input                     i_card_detect,
  input       [15:0]        i_timeout,
  input       [31:0]        i_block_sleep_count,
  output  reg               o_error_flag,
  output  reg [7:0]         o_error,
  input                     i_cmd_en,
  output  reg               o_cmd_finished_en,
  input       [5:0]         i_cmd,
  input       [31:0]        i_cmd_arg,
  input                     i_rsp_long,
  output      [127:0]       o_rsp,
  input                     i_data_txrx,
  input                     i_data_write_flag,
  input       [23:0]        i_data_size,
  output  reg               o_data_txrx_finished,
  input                     i_data_write_stb,
  input                     i_data_read_stb,
  input       [2:0]         i_func_addr,
  input                     i_data_block_mode,
  input       [23:0]        i_f0_block_size,
  input       [23:0]        i_f1_block_size,
  input       [23:0]        i_f2_block_size,
  input       [23:0]        i_f3_block_size,
  input       [23:0]        i_f4_block_size,
  input       [23:0]        i_f5_block_size,
  input       [23:0]        i_f6_block_size,
  input       [23:0]        i_f7_block_size,
  input       [23:0]        i_mem_block_size,
  output                    o_interrupt,
  output  reg               o_phy_cmd_en ,
  output  reg [39:0]        o_phy_cmd,
  output      [7:0]         o_phy_cmd_len,
  input                     i_phy_rsp_finished_en,
  input       [135:0]       i_phy_rsp,
  output      [7:0]         o_phy_rsp_len,
  input                     i_phy_crc_bad,
  output  reg               o_data_txrx_activate,
  input                     i_data_txrx_finished,
  output      [11:0]        o_data_byte_count,
  output                    o_data_write_flag,
  input                     i_data_crc_read_err
);
localparam    IDLE          = 4'h0;
localparam    TXRX_BLOCK    = 4'h1;
localparam    WAIT_RESPONSE = 4'h2;
localparam    BLOCK_SLEEP   = 4'h3;
localparam    FINISHED      = 4'h4;
reg           [3:0]         state;
reg           [3:0]         data_state;
reg           [23:0]        count;
reg                         infinite_data_txrx;
reg           [23:0]        transfer_count;
reg           [23:0]        block_count;
wire          [23:0]        func_block_size [0:7];
assign                      o_phy_cmd_len       = 8'd40;
assign                      o_rsp               = i_phy_rsp[127:0];
assign                      o_data_byte_count   = transfer_count[11:0];
assign                      o_data_write_flag   = i_data_write_flag;
assign                      func_block_size[0]  = i_f0_block_size;
assign                      func_block_size[1]  = i_f1_block_size;
assign                      func_block_size[2]  = i_f2_block_size;
assign                      func_block_size[3]  = i_f3_block_size;
assign                      func_block_size[4]  = i_f4_block_size;
assign                      func_block_size[5]  = i_f5_block_size;
assign                      func_block_size[6]  = i_f6_block_size;
assign                      func_block_size[7]  = i_f7_block_size;
assign                      o_phy_rsp_len       = i_rsp_long ? 8'd136 : 8'd40;
always @ (posedge clk) begin
  o_phy_cmd_en                  <= 0;
  if (rst) begin
    state                       <= IDLE;
    o_phy_cmd                   <= 0;
    o_error                     <= `ERROR_NO_ERROR;
    o_cmd_finished_en           <= 0;
  end
  else begin
    case (state)
      IDLE: begin
        o_phy_cmd_en            <=  0;
        o_cmd_finished_en       <=  0;
        o_error                 <= `ERROR_NO_ERROR;
        if (i_cmd_en) begin
          o_phy_cmd[39:38]      <= 2'b01;
          o_phy_cmd[37:32]      <= i_cmd;
          o_phy_cmd[31:0]       <= i_cmd_arg;
          o_phy_cmd_en          <= 1;
          state                 <= WAIT_RESPONSE;
        end
      end
      WAIT_RESPONSE: begin
        o_phy_cmd_en            <=  1;
        if (i_phy_rsp_finished_en) begin
          if (i_crc_enable_flag && i_phy_crc_bad) begin
            o_error             <= `ERROR_CRC_FAIL;
          end
          o_phy_cmd_en          <=  0;
          state                 <= FINISHED;
        end
      end
      FINISHED: begin
        o_cmd_finished_en       <=  1;
      end
      default: begin
      end
    endcase
    if (!i_cmd_en) begin
      state                       <=  IDLE;
    end
  end
end
always @ (posedge clk) begin
  if (rst) begin
    o_data_txrx_finished          <=  0;
    o_data_txrx_activate          <=  0;
    data_state                    <=  IDLE;
    count                         <=  0;
    transfer_count                <=  0;
    infinite_data_txrx            <=  0;
    block_count                   <=  0;
  end
  else begin
    case (data_state)
      IDLE: begin
        infinite_data_txrx        <=  0;
        o_data_txrx_finished      <=  0;
        o_data_txrx_activate      <=  0;
        count                     <=  0;
        block_count               <=  0;
        if (i_data_txrx) begin
          data_state              <=  TXRX_BLOCK;
          if (i_data_block_mode) begin
            if (i_data_size == 0) begin
              infinite_data_txrx  <=  1;
            end
            transfer_count        <=  func_block_size[i_func_addr];
          end
          else begin
            transfer_count        <=  i_data_size;
          end
        end
      end
      TXRX_BLOCK: begin
        count                   <=  0;
        o_data_txrx_activate    <=  1;
        data_state              <=  WAIT_RESPONSE;
        block_count             <=  block_count + 1;
      end
      WAIT_RESPONSE: begin
        if (i_data_txrx_finished) begin
          o_data_txrx_activate  <=  0;
          if (i_data_block_mode) begin
            if (infinite_data_txrx || (block_count < i_data_size)) begin
              data_state        <=  BLOCK_SLEEP;
            end
            else begin
              count             <=  0;
              data_state        <=  FINISHED;
            end
          end
          else begin
            data_state          <=  FINISHED;
          end
        end
      end
      BLOCK_SLEEP: begin
        if (count < i_block_sleep_count) begin
          count                 <=  count + 1;
        end
        else begin
          data_state            <=  TXRX_BLOCK;
        end
      end
      FINISHED: begin
        o_data_txrx_finished    <=  1;
      end
      default: begin
      end
    endcase
    if (!i_data_txrx) begin
      data_state              <=  IDLE;
    end
  end
end
endmodule