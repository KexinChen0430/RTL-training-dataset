
module memMod_dist(in,out,inAddr,outAddr,writeSel,clk);

  parameter  depth = 1024;
  parameter  width = 16;
  parameter  logDepth = 10;
  input  [(-1)+width:0] in;
  input  [(-1)+logDepth:0] inAddr,outAddr;
  input  writeSel,clk;
  output [(-1)+width:0] out;
  reg  [(-1)+width:0] out;
  reg  [(-1)+width:0] mem[depth+(-1):0];

  
  always @(posedge clk)
      begin
        out <= mem[outAddr];
        if (writeSel) mem[inAddr] <= in;
          
      end
endmodule

