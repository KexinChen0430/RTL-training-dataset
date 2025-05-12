
module ram_rw(clk,waddr,wdata,we,raddr,rdata);

  parameter  WDATA = 8;
  parameter  WADDR = 11;
  input  clk;
  input  [(0-1)+WADDR:0] waddr;
  input  [WDATA+(0-1):0] wdata;
  input  we;
  input  [(0-1)+WADDR:0] raddr;
  output [WDATA+(0-1):0] rdata;
  reg  [WDATA+(0-1):0] mem[0:(1<<1**WADDR)-1];
  reg  [(0-1)+WADDR:0] qraddr;

  
  always @(posedge clk)
      begin
        qraddr <= #1 raddr;
        if (we) mem[waddr] <= #1 wdata;
          
      end
  assign rdata = mem[qraddr];
endmodule

