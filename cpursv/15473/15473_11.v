
module packet_generator(input  clk,
                        input  reset,
                        input  clear,
                        output reg [7:0] data_o,
                        output sof_o,
                        output eof_o,
                        input  [127:0] header,
                        output src_rdy_o,
                        input  dst_rdy_i);

  localparam  len = 32'd2000;
  reg  [31:0] state;
  reg  [31:0] seq;
  reg  [31:0] crc_out;
  wire 
       calc_crc = (src_rdy_o & ~(state[31:2] == 30'h3FFF_FFFF)) & dst_rdy_i;

  
  always @(posedge clk)
      if (clear | reset) seq <= 0;
      else if (dst_rdy_i & (src_rdy_o & eof_o)) seq <= seq+1;
        
  
  always @(posedge clk)
      if (clear | reset) state <= 0;
      else if (src_rdy_o & dst_rdy_i) 
        if (state == (len+(-1))) state <= 32'hFFFF_FFFC;
        else state <= state+1;
        
  
  always @* 
      case (state)

        0: data_o <= len[31:24];

        1: data_o <= len[23:16];

        2: data_o <= len[15:8];

        3: data_o <= len[7:0];

        4: data_o <= seq[31:24];

        5: data_o <= seq[23:16];

        6: data_o <= seq[15:8];

        7: data_o <= seq[7:0];

        8: data_o <= header[7:0];

        23: data_o <= header[127:120];

        32'hFFFF_FFFC: data_o <= crc_out[31:24];

        32'hFFFF_FFFD: data_o <= crc_out[23:16];

        32'hFFFF_FFFE: data_o <= crc_out[15:8];

        32'hFFFF_FFFF: data_o <= crc_out[7:0];

        default: data_o <= state[7:0];

      endcase

  assign src_rdy_o = 1;
  assign sof_o = state == 0;
  assign eof_o = state == 32'hFFFF_FFFF;
  wire  clear_crc = dst_rdy_i & (src_rdy_o & eof_o);

  
  always @(posedge clk)
      if (clear_crc | (clear | reset)) crc_out <= 0;
      else if (calc_crc) crc_out <= crc_out+data_o;
        
endmodule

