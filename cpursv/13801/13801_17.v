
module ram  #(parameter  DATA_WIDTH = 8, ADDR_WIDTH = 8)
  (input  clk,
   input  we,
   input  [ADDR_WIDTH+(0-1):0] read_address,
   input  [ADDR_WIDTH+(0-1):0] write_address,
   input  [DATA_WIDTH+(0-1):0] data_i,
   output [DATA_WIDTH+(0-1):0] data_o);

  localparam  RAM_DEPTH = 1<<ADDR_WIDTH;
  reg  [DATA_WIDTH+(0-1):0] mem[0:RAM_DEPTH+(0-1)];
  reg  [DATA_WIDTH+(0-1):0] data_o_reg;

  assign data_o = data_o_reg;
  
  always @(posedge clk)
      begin
        data_o_reg <= mem[read_address];
        if (we) mem[write_address] <= data_i;
          
      end
endmodule

