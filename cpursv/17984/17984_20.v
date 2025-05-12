
module tmu2_dpram  #(parameter  depth = 11, width = 32)
  (input  sys_clk,
   input  [depth+(-1):0] ra,
   input  re,
   output [width+(-1):0] rd,
   input  [depth+(-1):0] wa,
   input  we,
   input  [width+(-1):0] wd);

  reg  [width+(-1):0] ram[0:1<<depth-1];
  reg  [depth+(-1):0] rar;

  
  always @(posedge sys_clk)
      begin
        if (re) rar <= ra;
          
        if (we) ram[wa] <= wd;
          
      end
  assign rd = ram[rar];
  integer i;

  
  initial  
  begin
    for (i = 0; i < 1<<depth; i = 1+i)
        ram[i] = 0;
  end
endmodule

