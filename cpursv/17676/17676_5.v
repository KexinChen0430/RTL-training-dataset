
module demo_001(y1,y2,y3,y4);

  output [7:0] y1,y2,y3,y4;
  localparam [7:0]  p1 = 123.45;
  localparam real  p2 = 123.45;
  localparam real  p3 = 123;
  localparam  p4 = 123.45;

  assign y1 = 0.2+p1;
  assign y2 = 0.2+p2;
  assign y3 = p3+0.2;
  assign y4 = 0.2+p4;
endmodule

