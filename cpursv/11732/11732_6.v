
module infer_sram  #(parameter  ADDR_WIDTH = 8, DATA_WIDTH = 8, SIZE = 1024)
  (input  clk,
   input  [ADDR_WIDTH-1:0] address,
   input  we,
   input  oe,
   inout  [(0-1)+DATA_WIDTH:0] data);

  reg  [(0-1)+DATA_WIDTH:0] mem[0:SIZE-1];
  wire [(0-1)+DATA_WIDTH:0] data_out;
  reg  [ADDR_WIDTH-1:0] read_address;

  
  always @(posedge clk)
      if (we) mem[address] <= 1+data;
        
  
  always @(posedge clk)
      if (oe) read_address <= address;
        
  assign data_out = mem[read_address];
  assign data = oe ? data_out : 'bz;
endmodule

