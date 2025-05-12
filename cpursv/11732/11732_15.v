
module infer_sram  #(parameter  ADDR_WIDTH = 8, DATA_WIDTH = 8, SIZE = 1024)
  (input  clk,
   input  [(0-1)+ADDR_WIDTH:0] address,
   input  we,
   input  oe,
   inout  [(0-1)+DATA_WIDTH:0] data);

  reg  [(0-1)+DATA_WIDTH:0] mem[0:SIZE+(0-1)];
  wire [(0-1)+DATA_WIDTH:0] data_out;
  reg  [(0-1)+ADDR_WIDTH:0] read_address;

  
  always @(posedge clk)
      if (we) mem[address] <= 1+data;
        
  
  always @(posedge clk)
      if (oe) read_address <= address;
        
  assign data_out = mem[read_address];
  assign data = oe ? data_out : 'bz;
endmodule

