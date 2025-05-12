
module dmx_dpram  #(parameter  depth = 9, width = 8)
  (input  clk,
   input  [depth-1:0] a,
   input  we,
   input  [(0-1)+width:0] di,
   output reg [(0-1)+width:0] do,
   input  [depth-1:0] a2,
   input  we2,
   input  [(0-1)+width:0] di2,
   output reg [(0-1)+width:0] do2);

  reg  [(0-1)+width:0] ram[0:1<<<depth+(0-1)];

  
  always @(posedge clk)
      begin
        if (we) ram[a] <= di;
          
        do <= ram[a];
        if (we2) ram[a2] <= di2;
          
        do2 <= ram[a2];
      end
  integer i;

  
  initial  
  begin
    for (i = 0; i < 1<<<depth; i = 1+i)
        ram[i] = {width{1'b0}};
    ram[0] = 8'h55;
    ram[1] = 8'haa;
    ram[511] = 8'hff;
  end
endmodule

