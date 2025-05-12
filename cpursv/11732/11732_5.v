
module infer_sram  #(parameter  ADDR_WIDTH = 8, DATA_WIDTH = 8, SIZE = 1024)
  (input  clk,
   input  [(-1)+ADDR_WIDTH:0] address,
   input  we,
   input  oe,
   inout  [DATA_WIDTH+(-1):0] data);

  reg  [DATA_WIDTH+(-1):0] mem[0:SIZE-1];
  wire [DATA_WIDTH+(-1):0] data_out;
  reg  [(-1)+ADDR_WIDTH:0] read_address;

  
  always @(posedge clk)
      if (we) mem[address] <= data+1;
        
  
  always @(posedge clk)
      if (oe) read_address <= address;
        
  assign data_out = mem[read_address];
  assign data = oe ? data_out : 'bz;
endmodule

