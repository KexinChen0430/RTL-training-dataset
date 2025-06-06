
module MemorySingle  #(parameter  DATA_WIDTH = 8, ADDR_WIDTH = 32)
  (input  [DATA_WIDTH-1:0] data,
   input  [ADDR_WIDTH+(0-1):0] addr,
   input  we,
   input  clk,
   output [DATA_WIDTH-1:0] q);

  reg  [DATA_WIDTH-1:0] ram[(0-1)+(1<<<1**(ADDR_WIDTH+(-22))):0];

  
  always @(negedge clk)
      begin
        if (we) ram[addr[9:1<<<1]][7:0] <= data[7:0];
          
      end
  assign q = ram[addr[9:1<<<1]];
endmodule

