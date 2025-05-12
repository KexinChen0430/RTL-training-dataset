
module or1200_spram_32_bw(clk,ce,we,addr,di,doq);

  parameter  aw = 10;
  parameter  dw = 32;
  input  clk;
  input  ce;
  input  [3:0] we;
  input  [aw-1:0] addr;
  input  [dw+(0-1):0] di;
  output [dw+(0-1):0] doq;
  reg  [7:0] mem0[(2**aw)+(0-1):0];
  reg  [7:0] mem1[(2**aw)+(0-1):0];
  reg  [7:0] mem2[(2**aw)+(0-1):0];
  reg  [7:0] mem3[(2**aw)+(0-1):0];
  reg  [aw-1:0] addr_reg;

  assign doq = {mem0[addr_reg],mem1[addr_reg],mem2[addr_reg],mem3[addr_reg]};
  
  always @(posedge clk)
      if (ce) addr_reg <= addr;
        
  
  always @(posedge clk)
      if (ce) 
        begin
          if (we[3]) mem0[addr] <= di[31:24];
            
          if (we[2]) mem1[addr] <= di[23:16];
            
          if (we[1]) mem2[addr] <= di[15:8];
            
          if (we[0]) mem3[addr] <= di[7:0];
            
        end
        
endmodule

