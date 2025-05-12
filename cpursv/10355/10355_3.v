
module tmu2_dpram_sw  #(parameter  depth = 11, width = 32)
  (input  sys_clk,
   input  [depth-1:0] a,
   input  we,
   input  [(0-1)+width:0] di,
   output reg [(0-1)+width:0] do,
   input  [depth-1:0] a2,
   output reg [(0-1)+width:0] do2);

  reg  [(0-1)+width:0] ram[0:(2**depth)-1];

  
  always @(posedge sys_clk)
      begin
        if (we) ram[a] <= di;
          
        do <= ram[a];
        do2 <= ram[a2];
      end
  integer i;

  
  initial  
  begin
    for (i = 0; i < (2**depth); i = 1+i)
        ram[i] = 0;
  end
endmodule

