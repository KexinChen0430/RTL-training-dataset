
module dcache_pmem_mux(input  clk_i,
                       input  rst_i,
                       input  outport_accept_i,
                       input  outport_ack_i,
                       input  outport_error_i,
                       input  [31:0] outport_read_data_i,
                       input  select_i,
                       input  [3:0] inport0_wr_i,
                       input  inport0_rd_i,
                       input  [7:0] inport0_len_i,
                       input  [31:0] inport0_addr_i,
                       input  [31:0] inport0_write_data_i,
                       input  [3:0] inport1_wr_i,
                       input  inport1_rd_i,
                       input  [7:0] inport1_len_i,
                       input  [31:0] inport1_addr_i,
                       input  [31:0] inport1_write_data_i,
                       output [3:0] outport_wr_o,
                       output outport_rd_o,
                       output [7:0] outport_len_o,
                       output [31:0] outport_addr_o,
                       output [31:0] outport_write_data_o,
                       output inport0_accept_o,
                       output inport0_ack_o,
                       output inport0_error_o,
                       output [31:0] inport0_read_data_o,
                       output inport1_accept_o,
                       output inport1_ack_o,
                       output inport1_error_o,
                       output [31:0] inport1_read_data_o);

  reg  [3:0] outport_wr_r;
  reg  outport_rd_r;
  reg  [7:0] outport_len_r;
  reg  [31:0] outport_addr_r;
  reg  [31:0] outport_write_data_r;
  reg  select_q;

  
  always @* 
      begin
        case (select_i)

          1'd1: begin
                outport_wr_r = inport1_wr_i;
                outport_rd_r = inport1_rd_i;
                outport_len_r = inport1_len_i;
                outport_addr_r = inport1_addr_i;
                outport_write_data_r = inport1_write_data_i;
              end

          default: begin
                outport_wr_r = inport0_wr_i;
                outport_rd_r = inport0_rd_i;
                outport_len_r = inport0_len_i;
                outport_addr_r = inport0_addr_i;
                outport_write_data_r = inport0_write_data_i;
              end

        endcase

      end
  assign outport_wr_o = outport_wr_r;
  assign outport_rd_o = outport_rd_r;
  assign outport_len_o = outport_len_r;
  assign outport_addr_o = outport_addr_r;
  assign outport_write_data_o = outport_write_data_r;
  
  always @(posedge clk_i or posedge rst_i)
      if (rst_i) select_q <= 1'b0;
      else select_q <= select_i;
  assign inport0_ack_o = (select_q == 1'd0) && outport_ack_i;
  assign inport0_error_o = (select_q == 1'd0) && outport_error_i;
  assign inport0_read_data_o = outport_read_data_i;
  assign inport0_accept_o = outport_accept_i && (select_i == 1'd0);
  assign inport1_ack_o = (select_q == 1'd1) && outport_ack_i;
  assign inport1_error_o = outport_error_i && (select_q == 1'd1);
  assign inport1_read_data_o = outport_read_data_i;
  assign inport1_accept_o = (select_i == 1'd1) && outport_accept_i;
endmodule

