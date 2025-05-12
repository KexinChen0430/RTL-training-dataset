module spi_reg(
  vio_data_regs, io_success, vio_tbus,
  i_rstb, i_clk_ext_osc, i_spi_active, vi_data_rx, i_rx_valid,
  vi_byte_num);
  input        i_rstb;
  input        i_clk_ext_osc;
  input        i_spi_active;
  input [7:0]  vi_data_rx;
  input        i_rx_valid;
  input [2:0]  vi_byte_num;
  inout [7:0]  vio_data_regs;
  inout        io_success;
  inout [36:0] vio_tbus;
  reg [7:0]    rv_addr;
  reg [36:0] rv_rd_mask;
  always @( * ) begin
    case ( rv_addr )
      default : rv_rd_mask = {NUM_REGS{1'b0}};
    endcase 
  end
  reg [NUM_REGS-1:0] rv_num_rd_bytes;
  always @( * ) begin
    case ( rv_addr )
      default : rv_num_rd_bytes = 0;
    endcase 
  end
  reg [NUM_REGS-1:0] rv_rd_tbus;
  reg [NUM_REGS-1:0] rv_wr_tbus;
  wire         active = i_rstb && i_spi_active;
  reg          r_read_tbus;
  reg          r_write_tbus;
  reg          r_clamp_success;
  always @( posedge i_rx_valid or negedge active ) begin : opcode_fsm
    if ( !active ) begin
      r_read_tbus <= 0;
      r_write_tbus <= 0;
      r_clamp_success <= 1;
    end else begin
      if ( 0 == vi_byte_num ) begin
        if ( 128 == vi_data_rx ) begin
          r_write_tbus <= 1;
          r_clamp_success <= 0;
        end
        if ( 192 == vi_data_rx ) begin
          r_read_tbus <= 1;
          r_clamp_success <= 0;
        end
      end
    end
  end 
  assign io_success = r_clamp_success ? 1'b0 : 1'bz;
  always @( posedge i_rx_valid or negedge active ) begin : address_fsm
    if ( !active ) begin
      rv_addr <= 0;
    end else begin
      if ( 1 == vi_byte_num )
        rv_addr <= vi_data_rx;
    end
  end
  reg [2:0]  rv_shadow_byte;
  reg [7:0]  rv_reg2spi;
  reg        r_ena_reg_read;
  always @( posedge i_rx_valid or negedge active ) begin : read_fsm
    if ( !active ) begin
      rv_shadow_byte <= 7;
      r_ena_reg_read <= 0;
    end else begin
      if (( 1 == vi_byte_num ) && r_read_tbus )
        r_ena_reg_read <= 1;
      if ( rv_num_rd_bytes >= vi_byte_num )
        rv_shadow_byte <= vi_byte_num - 1;
      else
        rv_shadow_byte <= 7;
    end
  end
  reg [36:0] rv_read_shadow;
  always @( * ) begin
    case ( rv_shadow_byte )
      0 : rv_reg2spi = rv_read_shadow[7:0];
      1 : rv_reg2spi = rv_read_shadow[15:8];
      2 : rv_reg2spi = rv_read_shadow[23:16];
      3 : rv_reg2spi = rv_read_shadow[31:24];
      4 : rv_reg2spi = {3'b000,rv_read_shadow[36:32]};
      default : rv_reg2spi = 0;
    endcase 
  end
  reg [36:0] rv_write_shadow;
  reg        r_ena_reg_write;
  reg        r_ser2par_done;
  always @( posedge i_rx_valid or negedge active ) begin : write_fsm
    if ( ! active ) begin
      r_ena_reg_write <= 0;
      r_ser2par_done <= 0;
      rv_write_shadow <= 0;
    end else begin
      if ( !r_ser2par_done ) begin
        if ( 2 == vi_byte_num )
          rv_write_shadow[7:0] <= vi_data_rx;
        if ( 3 == vi_byte_num )
          rv_write_shadow[15:8] <= vi_data_rx;
        if ( 4 == vi_byte_num )
          rv_write_shadow[23:16] <= vi_data_rx;
        if ( 5 == vi_byte_num )
          rv_write_shadow[31:24] <= vi_data_rx;
        if ( 6 == vi_byte_num )
          rv_write_shadow[36:32] <= vi_data_rx[4:0];
        if ( rv_num_rd_bytes < vi_byte_num ) begin
          r_ser2par_done <= 1;
          r_ena_reg_write <= r_write_tbus;
        end
      end
    end
  end
  reg [1:0] rv_rd_state;
  localparam READ_IDLE = 0;
  localparam READ_WAIT = 1;
  localparam READ_DONE = 2;
  always @( posedge i_clk_ext_osc or negedge active ) begin
    if ( !active ) begin
      rv_read_shadow <= 0;
      rv_rd_tbus <= 0;
      rv_rd_state <= READ_IDLE;
    end else begin
      if (( READ_IDLE == rv_rd_state ) && r_ena_reg_read ) begin
        rv_rd_tbus[rv_addr] <= 1;
        rv_rd_state <= READ_WAIT;
      end
      if (( READ_WAIT == rv_rd_state ) && io_success ) begin
        rv_read_shadow <= vio_tbus & rv_rd_mask;
        rv_rd_tbus <= 0;
        rv_rd_state <= READ_DONE;
      end
      if ( READ_DONE == rv_rd_state ) begin
        rv_rd_tbus <= 0;
        rv_rd_state <= READ_DONE;
      end
    end
  end
  reg [1:0] rv_wr_state;
  localparam WRITE_IDLE = 0;
  localparam WRITE_WAIT = 1;
  localparam WRITE_DONE = 2;
  always @( posedge i_clk_ext_osc or negedge active ) begin
    if ( !active ) begin
      rv_wr_tbus <= 0;
      rv_wr_state <= WRITE_IDLE;
    end else begin
      if (( WRITE_IDLE == rv_wr_state ) && r_ena_reg_write ) begin
        rv_wr_tbus[rv_addr] <= 1;
        rv_wr_state <= WRITE_WAIT;
      end
      if (( WRITE_WAIT == rv_wr_state ) && io_success ) begin
        rv_wr_tbus <= 0;
        rv_wr_state <= WRITE_DONE;
      end
      if ( WRITE_DONE == rv_wr_state ) begin
        rv_wr_tbus <= 0;
        rv_wr_state <= WRITE_DONE;
      end
    end
  end
  assign vio_tbus = r_write_tbus ? rv_write_shadow : 37'bz;
  assign vio_data_regs = r_read_tbus ? rv_reg2spi : 8'bz;
endmodule