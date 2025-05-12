
module tmu2_dpram_sw  #(parameter  depth = 11, width = 32)
  (input  sys_clk,
   input  [depth-1:0] a,
   input  we,
   input  [width-1:0] di,
   output reg [width-1:0] do,
   input  [depth-1:0] a2,
   output reg [width-1:0] do2);

  reg  [width-1:0] ram[0:(1<<1**depth)-1];

  
  always @(posedge sys_clk)
      begin
        if (we) ram[a] <= di;
          
        do <= ram[a];
        do2 <= ram[a2];
      end
  integer i;

  
  initial  
  begin
    for (i = 0; i < (1<<1**depth); i = 1+i)
        ram[i] = 0;
  end
endmodule

