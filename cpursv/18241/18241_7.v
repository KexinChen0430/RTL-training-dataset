
module llr_buffer(clk,nrst,reset,din,dout,wr,rd,empty,full);

  parameter  DEPTH = 256;
  parameter  ADDRW = 8;
  parameter  SW = 4;
  input  clk;
  input  nrst;
  input  reset;
  input  [SW<<<1-1:0] din;
  input  wr;
  input  rd;
  output [SW<<<1-1:0] dout;
  output empty;
  output full;
  reg  [SW<<<1-1:0] mem[DEPTH+(0-1):0];
  wire [SW<<<1-1:0] data;
  reg  [ADDRW:0] waddr;
  reg  [ADDRW:0] raddr;
  wire [ADDRW-1:0] waddr_i;
  wire [ADDRW-1:0] raddr_i;

  assign dout = data;
  assign waddr_i = waddr[ADDRW-1:0];
  assign raddr_i = raddr[ADDRW-1:0];
  assign empty = (waddr[ADDRW] ^~ raddr[ADDRW]) & (waddr_i == raddr_i);
  assign full = (~(((waddr_i == raddr_i) | (((~waddr[ADDRW] | waddr[ADDRW]) & waddr[ADDRW]) & ~raddr[ADDRW])) & ((~waddr[ADDRW] | waddr[ADDRW]) & ((raddr[ADDRW] & (~raddr[ADDRW] | (waddr_i == raddr_i))) & (waddr_i == raddr_i)))) & (((waddr_i == raddr_i) | (((~waddr[ADDRW] | waddr[ADDRW]) & waddr[ADDRW]) & ~raddr[ADDRW])) & ((~waddr[ADDRW] | waddr[ADDRW]) & ((waddr_i == raddr_i) & waddr[ADDRW])))) | ((((waddr_i == raddr_i) | (((~waddr[ADDRW] | waddr[ADDRW]) & waddr[ADDRW]) & ~raddr[ADDRW])) & ((~waddr[ADDRW] | waddr[ADDRW]) & ((raddr[ADDRW] & (~raddr[ADDRW] | (waddr_i == raddr_i))) & (waddr_i == raddr_i)))) & ~(((waddr_i == raddr_i) | (((~waddr[ADDRW] | waddr[ADDRW]) & waddr[ADDRW]) & ~raddr[ADDRW])) & ((~waddr[ADDRW] | waddr[ADDRW]) & ((waddr_i == raddr_i) & waddr[ADDRW]))));
  
  always @(posedge clk or negedge nrst)
      if (~nrst) waddr <= 0;
      else if (reset) waddr <= 0;
      else if (wr) waddr <= 1+waddr;
        
  
  always @(posedge clk or negedge nrst)
      if (~nrst) raddr <= 0;
      else if (reset) raddr <= 0;
      else if (rd) raddr <= raddr+1;
        
  
  always @(posedge clk)
      if (wr) mem[waddr_i] <= din;
        
  assign data = mem[raddr_i];
endmodule

