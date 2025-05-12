
module offset_flag_to_one_hot  #(parameter  C_WIDTH = 4)
  (input  [clog2s(C_WIDTH)+(-1):0] WR_OFFSET,
   input  WR_FLAG,
   output [(-1)+C_WIDTH:0] RD_ONE_HOT);

  assign RD_ONE_HOT = {{(-1)+C_WIDTH{1'b0}},WR_FLAG}<<WR_OFFSET;
endmodule

