module gt32b;
  wire real rlval;
  wire rval;
  wire aval[1:0];
  wire [7:0] psval;
  assign #1 rlval = 1.0;
  assign #2 rval = 1'b1;
  assign #3 aval[0] = 1'b0;
  assign #4 psval[1] = 1'b1;
  initial begin
    $timeformat(-12, 0, " ps", 16);
    #1;
    $display("dl:gt32b- %t", $realtime);
  end
  always @(rlval) begin
    $display("rl:gt32b- %t", $realtime);
  end
  always @(rval) begin
    $display("rg:gt32b- %t", $realtime);
  end
  always @(aval[0]) begin
    $display("ar:gt32b- %t", $realtime);
  end
  always @(psval) begin
    $display("ps:gt32b- %t", $realtime);
  end
endmodule