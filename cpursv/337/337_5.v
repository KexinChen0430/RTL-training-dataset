
module rotate_right  #(parameter  M = 4, S = 0)
  (input  [(0-1)+M:0] in,
   output [(0-1)+M:0] out);

  wire [(2*M)+(0-1):0]  in2 = {in,in};

  assign out = in2[S%M +: M];
endmodule

