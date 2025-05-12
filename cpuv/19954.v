module issue01144(input clk, d, output q);
specify
  (posedge clk => (q +: d)) = (3,1); 
  (posedge clk *> (q +: d)) = (3,1); 
endspecify
endmodule