module test6(input clk, d, e, output q);
specify
  (d[0] *> q[0]) = (3,1);
  (posedge clk[0] => (q[0] +: d[0])) = (3,1);
endspecify
endmodule