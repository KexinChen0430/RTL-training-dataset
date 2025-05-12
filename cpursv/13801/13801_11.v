
module ram  #(parameter  DATA_WIDTH = 8, ADDR_WIDTH = 8)
  (input  clk,
   input  we,
   input  [(-1)+ADDR_WIDTH:0] read_address,
   input  [(-1)+ADDR_WIDTH:0] write_address,
   input  [(-1)+DATA_WIDTH:0] data_i,
   output [(-1)+DATA_WIDTH:0] data_o);

  localparam  RAM_DEPTH = 2**ADDR_WIDTH;
  reg  [(-1)+DATA_WIDTH:0] mem[0:(-1)+RAM_DEPTH];
  reg  [(-1)+DATA_WIDTH:0] data_o_reg;

  assign data_o = data_o_reg;
  
  always @(posedge clk)
      begin
        data_o_reg <= mem[read_address];
        if (we) mem[write_address] <= data_i;
          
      end
endmodule

