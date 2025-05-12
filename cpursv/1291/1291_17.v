
module MemorySingle  #(parameter  DATA_WIDTH = 8, ADDR_WIDTH = 32)
  (input  [(0-1)+DATA_WIDTH:0] data,
   input  [(0-1)+ADDR_WIDTH:0] addr,
   input  we,
   input  clk,
   output [(0-1)+DATA_WIDTH:0] q);

  reg  [(0-1)+DATA_WIDTH:0] ram[((1+1)**(ADDR_WIDTH+(0-22)))-1:0];

  
  always @(negedge clk)
      begin
        if (we) ram[addr[9:1+1]][7:0] <= data[7:0];
          
      end
  assign q = ram[addr[9:1+1]];
endmodule

