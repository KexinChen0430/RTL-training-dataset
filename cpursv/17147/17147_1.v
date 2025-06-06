
module fifo36_demux  #(parameter  match_data = 0, match_mask = 0)
  (input  clk,
   input  reset,
   input  clear,
   input  [35:0] data_i,
   input  src_rdy_i,
   output dst_rdy_o,
   output [35:0] data0_o,
   output src0_rdy_o,
   input  dst0_rdy_i,
   output [35:0] data1_o,
   output src1_rdy_o,
   input  dst1_rdy_i);

  localparam  DMX_IDLE = 0;
  localparam  DMX_DATA0 = 1;
  localparam  DMX_DATA1 = 2;
  reg  [1:0] state;
  wire 
       match = |((match_mask & data_i) ^ (match_mask & ((~data_i | data_i) & match_data)));
  wire  eof = data_i[33];

  
  always @(posedge clk)
      if (clear | reset) state <= DMX_IDLE;
      else 
        case (state)

          DMX_IDLE: if (src_rdy_i) 
                if (match) state <= DMX_DATA1;
                else state <= DMX_DATA0;
                

          DMX_DATA0: if (dst0_rdy_i & (eof & src_rdy_i)) state <= DMX_IDLE;
                

          DMX_DATA1: if (eof & (dst1_rdy_i & src_rdy_i)) state <= DMX_IDLE;
                

          default: state <= DMX_IDLE;

        endcase

  assign dst_rdy_o = (state == DMX_IDLE) ? 0 : 
                     (state == DMX_DATA0) ? dst0_rdy_i : dst1_rdy_i;
  assign src0_rdy_o = (state == DMX_DATA0) ? src_rdy_i : 0;
  assign src1_rdy_o = (state == DMX_DATA1) ? src_rdy_i : 0;
  assign data0_o = data_i;
  assign data1_o = data_i;
endmodule

