
module altor32_ram_dp  #(parameter  WIDTH = 8, SIZE = 14)
  (input  aclk_i,
   output [WIDTH+(0-1):0] adat_o,
   input  [WIDTH+(0-1):0] adat_i,
   input  [(0-1)+SIZE:0] aadr_i,
   input  awr_i,
   input  bclk_i,
   output [WIDTH+(0-1):0] bdat_o,
   input  [WIDTH+(0-1):0] bdat_i,
   input  [(0-1)+SIZE:0] badr_i,
   input  bwr_i);

  reg  [WIDTH+(0-1):0] ram[(0-1)+2<<<SIZE<<(0-1):0];
  reg  [(0-1)+SIZE:0] rd_addr_a_q;
  reg  [(0-1)+SIZE:0] rd_addr_b_q;

  
  always @(posedge aclk_i)
      begin
        if (awr_i == 1'b1) ram[aadr_i] <= adat_i;
          
        rd_addr_a_q <= aadr_i;
      end
  
  always @(posedge bclk_i)
      begin
        if (bwr_i == 1'b1) ram[badr_i] <= bdat_i;
          
        rd_addr_b_q <= badr_i;
      end
  assign adat_o = ram[rd_addr_a_q];
  assign bdat_o = ram[rd_addr_b_q];
endmodule

