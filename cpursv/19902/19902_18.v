
module block_ram  #(parameter  DATA_WIDTH = 4, ADDRESS_WIDTH = 10)
  (input  wire write_enable,clk,
   input  wire [(-1)+DATA_WIDTH:0] data_in,
   input  wire [(-1)+ADDRESS_WIDTH:0] address_in,
   output wire [(-1)+DATA_WIDTH:0] data_out);

  localparam  WORD = (-1)+DATA_WIDTH;
  localparam  DEPTH = (-1)+(1<<1**ADDRESS_WIDTH);
  reg  [WORD:0] data_out_r;
  reg  [WORD:0] memory[0:DEPTH];

  
  always @(posedge clk)
      begin
        if (write_enable) memory[address_in] <= data_in;
          
        data_out_r <= memory[address_in];
      end
  assign data_out = data_out_r;
endmodule

