
module SRAM(input  clk,read,write,
            input  [7:0] X,Y,
            input  [11:0] DATIN,
            output [11:0] DATOUT,
            output reg wAck,
            output reg [11:0] wDbg);

  parameter  W = 200, H = 150;
  reg  [11:0] mem[(H*W)+(0-1):0];
  reg  [11:0] DATOUTINV;

  assign DATOUT = ~DATOUTINV;
  
  always @(posedge clk)
      begin
        if (read) DATOUTINV <= mem[(W*Y)+X];
        else if (write) 
          begin
            mem[(W*Y)+X] <= ~DATIN;
            wDbg <= DATIN;
            wAck <= 1;
          end
        else wAck <= 0;
      end
endmodule

