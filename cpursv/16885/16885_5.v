
module wb_reg  #(parameter  ADDR = 0, DEFAULT = 0, WIDTH = 32)
  (input  clk,
   input  rst,
   input  [5:0] adr,
   input  wr_acc,
   input  [31:0] dat_i,
   output reg [WIDTH+(0-1):0] dat_o);

  
  always @(posedge clk)
      if (rst) dat_o <= DEFAULT;
      else if ((adr == ADDR) & wr_acc) dat_o <= dat_i[WIDTH+(0-1):0];
        
endmodule

