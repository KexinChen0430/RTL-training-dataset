
module fifo19_to_ll8(input  clk,
                     input  reset,
                     input  clear,
                     input  [18:0] f19_data,
                     input  f19_src_rdy_i,
                     output f19_dst_rdy_o,
                     output reg [7:0] ll_data,
                     output ll_sof_n,
                     output ll_eof_n,
                     output ll_src_rdy_n,
                     input  ll_dst_rdy_n);

  wire ll_sof,ll_eof,ll_src_rdy;

  assign ll_sof_n = ~ll_sof;
  assign ll_eof_n = ~ll_eof;
  assign ll_src_rdy_n = ~ll_src_rdy;
  wire  ll_dst_rdy = ~ll_dst_rdy_n;

  wire  f19_sof = f19_data[16];

  wire  f19_eof = f19_data[17];

  wire  f19_occ = f19_data[18];

  wire advance,end_early;

  reg  state;

  
  always @(posedge clk)
      if (reset) state <= 0;
      else if (advance) 
        if (ll_eof) state <= 0;
        else state <= 1+state;
        
  
  always @* 
      case (state)

        0: ll_data = f19_data[15:8];

        1: ll_data = f19_data[7:0];

        default: ll_data = f19_data[15:8];

      endcase

  assign ll_sof = f19_sof & (state == 0);
  assign ll_eof = (((state == 1) & f19_eof) | ((f19_occ == 1) & ((state == 1) | (((state == 1) & (f19_occ == 1)) | f19_eof)))) & f19_eof;
  assign ll_src_rdy = f19_src_rdy_i;
  assign advance = ll_dst_rdy & ll_src_rdy;
  assign f19_dst_rdy_o = advance & (((ll_eof & (((state == 1) & (advance | ll_eof)) | (advance & ll_eof))) | ((((state == 1) & (f19_occ == 1)) & f19_eof) | (((state == 1) & ll_eof) & advance))) | (state == 1));
endmodule

