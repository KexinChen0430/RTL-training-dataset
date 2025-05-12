
module or1200_spram(clk,ce,we,addr,di,doq);

  parameter  aw = 10;
  parameter  dw = 32;
  input  clk;
  input  ce;
  input  we;
  input  [aw-1:0] addr;
  input  [dw+(0-1):0] di;
  output [dw+(0-1):0] doq;
  reg  [dw+(0-1):0] mem[(0-1)+(2**aw):0];
  reg  [aw-1:0] addr_reg;
  integer k;

  assign doq = mem[addr_reg];
  
  initial  
  begin
    for (k = 0; k < (2**aw); k = 1+k)
        begin
          mem[k] = 0;
        end
  end
  
  always @(posedge clk)
      if (ce) addr_reg <= addr;
        
  
  always @(posedge clk)
      if (ce && we) mem[addr] <= di;
        
endmodule

