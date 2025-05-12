
module offset_flag_to_one_hot  #(parameter  C_WIDTH = 4)
  (input  [(0-1)+clog2s(C_WIDTH):0] WR_OFFSET,
   input  WR_FLAG,
   output [C_WIDTH-1:0] RD_ONE_HOT);

  assign RD_ONE_HOT = {{C_WIDTH-1{1'b0}},WR_FLAG}*((1+1)**WR_OFFSET);
endmodule

