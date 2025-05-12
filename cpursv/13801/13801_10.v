
module ram  #(parameter  DATA_WIDTH = 8, ADDR_WIDTH = 8)
  (input  clk,
   input  we,
   input  [ADDR_WIDTH+(0-1):0] read_address,
   input  [ADDR_WIDTH+(0-1):0] write_address,
   input  [(0-1)+DATA_WIDTH:0] data_i,
   output [(0-1)+DATA_WIDTH:0] data_o);

  localparam  RAM_DEPTH = 1<<ADDR_WIDTH;
  reg  [(0-1)+DATA_WIDTH:0] mem[0:(0-1)+RAM_DEPTH];
  reg  [(0-1)+DATA_WIDTH:0] data_o_reg;

  assign data_o = data_o_reg;
  
  always @(posedge clk)
      begin
        data_o_reg <= mem[read_address];
        if (we) mem[write_address] <= data_i;
          
      end
endmodule

