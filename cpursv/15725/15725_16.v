
module packet_resizer_variable(input  clk,
                               input  reset,
                               input  [15:0] next_dst_sid,
                               input  [15:0] pkt_size,
                               input  [31:0] i_tdata,
                               input  [127:0] i_tuser,
                               input  i_tlast,
                               input  i_tvalid,
                               output i_tready,
                               output [31:0] o_tdata,
                               output [127:0] o_tuser,
                               output o_tlast,
                               output o_tvalid,
                               input  o_tready);

  reg  [15:0] count;
  reg   first_packet_in_burst = 1'b1;
  wire [1:0]  TYPE_in = i_tuser[127:126];
  wire  TSI_in = i_tuser[125];
  wire  EOB_in = i_tuser[124];
  wire [11:0]  SEQ_in = i_tuser[123:112];
  wire [15:0]  LEN_in = i_tuser[111:96];
  wire [15:0]  SRC_in = i_tuser[95:80];
  wire [15:0]  DST_in = i_tuser[79:64];
  wire [63:0]  TIME_in = i_tuser[63:0];
  wire [1:0]  TYPE_out = TYPE_in;
  wire  TSI_out = first_packet_in_burst & TSI_in;
  wire  EOB_out = i_tlast & EOB_in;
  wire [11:0]  SEQ_out = SEQ_in;
  wire [15:0]  LEN_out = LEN_in;
  wire [15:0]  SRC_out = DST_in;
  wire [15:0]  DST_out = next_dst_sid;
  wire [63:0]  TIME_out = TIME_in;

  assign o_tdata = i_tdata;
  assign o_tlast = EOB_out | (count == pkt_size);
  assign o_tuser = {TYPE_out,TSI_out,EOB_out,SEQ_out,LEN_out,SRC_out,DST_out,TIME_out};
  assign o_tvalid = i_tvalid;
  assign i_tready = o_tready;
  
  always @(posedge clk)
      if (reset) count <= 16'd1;
      else if (o_tready & o_tvalid) 
        if (o_tlast) count <= 16'd1;
        else count <= 16'd1+count;
        
  
  always @(posedge clk)
      if (reset) first_packet_in_burst <= 1'b1;
      else if ((o_tlast & o_tvalid) & o_tready) first_packet_in_burst <= EOB_out;
        
endmodule

