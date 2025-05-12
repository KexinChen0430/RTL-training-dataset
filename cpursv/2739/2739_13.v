
module delay_fifo  #(parameter  DLY = 3, DW = 32)
  (input  wire clk,
   input  wire rst,
   input  wire sti_valid,
   input  wire [DW-1:0] sti_data,
   output wire sto_valid,
   output wire [DW-1:0] sto_data);

  reg  [(0-1)+(DLY*(1+DW)):0] mem;

  
  always @(posedge clk)
      mem <= {mem,{sti_valid,sti_data}};
  assign {sto_valid,sto_data} = mem[(1+DW)*(DLY+(0-1)) +: 1+DW];
endmodule

