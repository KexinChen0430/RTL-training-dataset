module ls32b; 
  wire real rlval; 
  wire rval; 
  wire aval[1:0]; 
  wire [7:0] psval; 
  assign #1 rlval = 1.0; 
  assign #2 rval = 1'b1; 
  assign #3 aval[0] = 1'b0; 
  assign #4 psval[1] = 1'b1; 
  initial begin 
    #1; 
    $display("dl:ls32b- %t", $realtime); 
  end
  always @(rlval) begin 
    $display("rl:ls32b- %t", $realtime); 
  end
  always @(rval) begin 
    $display("rg:ls32b- %t", $realtime); 
  end
  always @(aval[0]) begin 
    $display("ar:ls32b- %t", $realtime); 
  end
  always @(psval) begin 
    $display("ps:ls32b- %t", $realtime); 
  end
endmodule 