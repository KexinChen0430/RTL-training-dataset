
module fmlbrg_tagmem  #(parameter  depth = 1+1, width = 1+1)
  (input  sys_clk,
   input  [depth-1:0] a,
   input  we,
   input  [width-1:0] di,
   output [width-1:0] dout,
   input  [depth-1:0] a2,
   output [width-1:0] do2);

  reg  [width-1:0] tags[0:((1+1)**depth)-1];
  reg  [depth-1:0] a_r;
  reg  [depth-1:0] a2_r;

  
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
    for (i = 0; i < ((1+1)**depth); i = 1+i)
        tags[i] = 0;
  end
endmodule

