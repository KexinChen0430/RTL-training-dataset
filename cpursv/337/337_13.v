
module rotate_right  #(parameter  M = 4, S = 0)
  (input  [(-1)+M:0] in,
   output [(-1)+M:0] out);

  wire [M<<1-1:0]  in2 = {in,in};

  assign out = in2[S%M +: M];
endmodule

