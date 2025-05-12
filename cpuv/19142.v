module test_bufif0 (); 
wire t0, t1, t2, t3, t4, t5, t6, t7,
     t8, t9, ta, tb, tc, td, te, tf;
reg gnd, vdd, x, z;
reg failed;
wire StH, StL;
assign (strong1, highz0)  StH = 1'bx;
assign (highz1,  strong0) StL = 1'bx;
bufif0 n0 ( t0,  gnd,  gnd);
bufif0 n1 ( t1,  gnd,  vdd);
bufif0 n2 ( t2,  gnd,  x);
bufif0 n3 ( t3,  gnd,  z);
bufif0 n4 ( t4,  vdd,  gnd);
bufif0 n5 ( t5,  vdd,  vdd);
bufif0 n6 ( t6,  vdd,  x);
bufif0 n7 ( t7,  vdd,  z);
bufif0 n8 ( t8,  x,  gnd);
bufif0 n9 ( t9,  x,  vdd);
bufif0 na ( ta,  x,  x);
bufif0 nb ( tb,  x,  z);
bufif0 nc ( tc,  z,  gnd);
bufif0 nd ( td,  z,  vdd);
bufif0 ne ( te,  z,  x);
bufif0 nf ( tf,  z,  z);
initial begin
  assign gnd = 1'b1;
  assign vdd = 1'b0;
  assign x = 1'b0;
  assign z = 1'b0;
  #10; 
  assign gnd = 1'b0;
  assign vdd = 1'b1;
  assign x = 1'b1;
  assign z = 1'b1;
  #10; 
  assign gnd = 1'b0;
  assign vdd = 1'b1;
  assign x = 1'bx;
  assign z = 1'bz;
  #10; 
  failed = 0;
  if (t0 !== gnd) begin
      failed = 1;
      $display ("FAILED: bufif0 s:%d g:%d d:%d expected:0", gnd, gnd, t0 );
  end
  if (failed == 0)
      $display ("PASSED");
end
endmodule 