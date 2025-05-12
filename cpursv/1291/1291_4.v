
module MemorySingle  #(parameter  DATA_WIDTH = 8, ADDR_WIDTH = 32)
  (input  [(-1)+DATA_WIDTH:0] data,
   input  [(-1)+ADDR_WIDTH:0] addr,
   input  we,
   input  clk,
   output [(-1)+DATA_WIDTH:0] q);

  reg  [(-1)+DATA_WIDTH:0] ram[(2**((0-22)+ADDR_WIDTH))-1:0];

  
  always @(negedge clk)
      begin
        if (we) ram[addr[9:2]][7:0] <= data[7:0];
          
      end
  assign q = ram[addr[9:2]];
endmodule

