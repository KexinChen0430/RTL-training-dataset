
module oh_oddr  #(parameter  DW = 1)
  (input  clk,
   input  [(0-1)+DW:0] din1,
   input  [(0-1)+DW:0] din2,
   output [(0-1)+DW:0] out);

  reg  [(0-1)+DW:0] q1_sl;
  reg  [(0-1)+DW:0] q2_sl;
  reg  [(0-1)+DW:0] q2_sh;

  
  always @(posedge clk)
      begin
        q1_sl[(0-1)+DW:0] <= din1[(0-1)+DW:0];
        q2_sl[(0-1)+DW:0] <= din2[(0-1)+DW:0];
      end
  
  always @(negedge clk)
      q2_sh[(0-1)+DW:0] <= q2_sl[(0-1)+DW:0];
  assign out[(0-1)+DW:0] = clk ? q1_sl[(0-1)+DW:0] : q2_sh[(0-1)+DW:0];
endmodule

