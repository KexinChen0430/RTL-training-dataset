
module manually_extended_logical_or(a,b,yuu,yus,ysu,yss);

  input  [7:0] a,b;
  output [15:0] yuu,yus,ysu,yss;

  assign yuu = {{8{1'b0}},b} | {{8{1'b0}},a};
  assign yus = {{8{1'b0}},b} | {{8{1'b0}},a};
  assign ysu = {{8{1'b0}},b} | {{8{1'b0}},a};
  assign yss = {{8{a[7]}},a} | {{8{b[7]}},b};
endmodule

