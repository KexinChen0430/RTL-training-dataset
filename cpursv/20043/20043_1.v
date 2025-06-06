
module sync_ram_sdp  #(parameter  DATA_WIDTH = 8, ADDRESS_WIDTH = 10)
  (input  wire clk,write_enable,
   input  wire [(0-1)+DATA_WIDTH:0] data_in,
   input  wire [(0-1)+ADDRESS_WIDTH:0] address_in_r,address_in_w,
   output wire [(0-1)+DATA_WIDTH:0] data_out);

  localparam  WORD = (0-1)+DATA_WIDTH;
  localparam  DEPTH = (0-1)+(2**ADDRESS_WIDTH);
  reg  [WORD:0] data_out_r;
  reg  [WORD:0] memory[0:DEPTH];

  
  always @(posedge clk)
      begin
        if (write_enable) memory[address_in_w] <= data_in;
          
        data_out_r <= memory[address_in_r];
      end
  assign data_out = data_out_r;
endmodule

