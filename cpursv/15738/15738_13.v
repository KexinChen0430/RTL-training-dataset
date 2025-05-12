
module ram_rw(clk,waddr,wdata,we,raddr,rdata);

  parameter  WDATA = 8;
  parameter  WADDR = 11;
  input  clk;
  input  [WADDR-1:0] waddr;
  input  [(-1)+WDATA:0] wdata;
  input  we;
  input  [WADDR-1:0] raddr;
  output [(-1)+WDATA:0] rdata;
  reg  [(-1)+WDATA:0] mem[0:((1+1)**WADDR)-1];
  reg  [WADDR-1:0] qraddr;

  
  always @(posedge clk)
      begin
        qraddr <= #1 raddr;
        if (we) mem[waddr] <= #1 wdata;
          
      end
  assign rdata = mem[qraddr];
endmodule

