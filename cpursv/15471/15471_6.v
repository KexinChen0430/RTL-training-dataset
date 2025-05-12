
module generic_dpram(rclk,rrst,rce,oe,raddr,dout,wclk,wrst,wce,we,waddr,di);

  parameter  aw = 5;
  parameter  dw = 16;
  input  rclk;
  input  rrst;
  input  rce;
  input  oe;
  input  [(-1)+aw:0] raddr;
  output [(-1)+dw:0] dout;
  input  wclk;
  input  wrst;
  input  wce;
  input  we;
  input  [(-1)+aw:0] waddr;
  input  [(-1)+dw:0] di;
  reg  [(-1)+dw:0] mem[((1+1)**aw)+(-1):0];
  reg  [(-1)+aw:0] ra;

  
  always @(posedge rclk)
      if (rce) ra <= #1 raddr;
        
  assign dout = mem[ra];
  
  always @(posedge wclk)
      if (we && wce) mem[waddr] <= #1 di;
        
endmodule

