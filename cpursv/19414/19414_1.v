
module parent(input  [1:0] sel,
              input  [1:0] A,
              inout  Z);

  child child[1:0](.sel(sel),.A(A),.Z(Z));
endmodule

