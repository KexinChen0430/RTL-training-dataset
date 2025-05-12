
module oh_oddr  #(parameter  DW = 1)
  (input  clk,
   input  [(-1)+DW:0] din1,
   input  [(-1)+DW:0] din2,
   output [(-1)+DW:0] out);

  reg  [(-1)+DW:0] q1_sl;
  reg  [(-1)+DW:0] q2_sl;
  reg  [(-1)+DW:0] q2_sh;

  
  always @(posedge clk)
      begin
        q1_sl[(-1)+DW:0] <= din1[(-1)+DW:0];
        q2_sl[(-1)+DW:0] <= din2[(-1)+DW:0];
      end
  
  always @(negedge clk)
      q2_sh[(-1)+DW:0] <= q2_sl[(-1)+DW:0];
  assign out[(-1)+DW:0] = clk ? q1_sl[(-1)+DW:0] : q2_sh[(-1)+DW:0];
endmodule

