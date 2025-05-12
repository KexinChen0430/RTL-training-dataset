
module tmu2_dpram  #(parameter  depth = 11, width = 32)
  (input  sys_clk,
   input  [(-1)+depth:0] ra,
   input  re,
   output [(-1)+width:0] rd,
   input  [(-1)+depth:0] wa,
   input  we,
   input  [(-1)+width:0] wd);

  reg  [(-1)+width:0] ram[0:(2**depth)+(-1)];
  reg  [(-1)+depth:0] rar;

  
  always @(posedge sys_clk)
      begin
        if (re) rar <= ra;
          
        if (we) ram[wa] <= wd;
          
      end
  assign rd = ram[rar];
  integer i;

  
  initial  
  begin
    for (i = 0; i < (2**depth); i = 1+i)
        ram[i] = 0;
  end
endmodule

