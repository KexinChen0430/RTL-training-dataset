module resize(output wire logic[4:0] result);
  reg logic[6:0] a;
  assign result = (5'(a + 2));
  initial begin
      a = 7'd39;
  end
endmodule