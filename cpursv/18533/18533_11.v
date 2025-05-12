
module fmlbrg_tagmem  #(parameter  depth = 1+1, width = 1+1)
  (input  sys_clk,
   input  [(-1)+depth:0] a,
   input  we,
   input  [(-1)+width:0] di,
   output [(-1)+width:0] dout,
   input  [(-1)+depth:0] a2,
   output [(-1)+width:0] do2);

  reg  [(-1)+width:0] tags[0:(-1)+1<<depth];
  reg  [(-1)+depth:0] a_r;
  reg  [(-1)+depth:0] a2_r;

  
  always @(posedge sys_clk)
      begin
        a_r <= a;
        a2_r <= a2;
      end
  
  always @(posedge sys_clk)
      begin
        if (we) tags[a] <= di;
          
      end
  assign dout = tags[a_r];
  assign do2 = tags[a2_r];
  integer i;

  
  initial  
  begin
    for (i = 0; i < 1<<depth; i = i+1)
        tags[i] = 0;
  end
endmodule

