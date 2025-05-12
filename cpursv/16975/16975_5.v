
module altor32_ram_dp  #(parameter  WIDTH = 8, SIZE = 14)
  (input  aclk_i,
   output [(-1)+WIDTH:0] adat_o,
   input  [(-1)+WIDTH:0] adat_i,
   input  [SIZE+(-1):0] aadr_i,
   input  awr_i,
   input  bclk_i,
   output [(-1)+WIDTH:0] bdat_o,
   input  [(-1)+WIDTH:0] bdat_i,
   input  [SIZE+(-1):0] badr_i,
   input  bwr_i);

  reg  [(-1)+WIDTH:0] ram[((1<<1**((-1)+1))*(1<<1**SIZE))-1:0];
  reg  [SIZE+(-1):0] rd_addr_a_q;
  reg  [SIZE+(-1):0] rd_addr_b_q;

  
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

