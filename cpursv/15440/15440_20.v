
module ram_dp8(aclk_i,aadr_i,adat_i,awr_i,adat_o,bclk_i,badr_i,bdat_i,bwr_i,
               bdat_o);

  parameter [31:0]  WIDTH = 8;
  parameter [31:0]  SIZE = 14;
  input  aclk_i;
  output [(-1)+WIDTH:0] adat_o;
  input  [(-1)+WIDTH:0] adat_i;
  input  [(-1)+SIZE:0] aadr_i;
  input  awr_i;
  input  bclk_i;
  output [(-1)+WIDTH:0] bdat_o;
  input  [(-1)+WIDTH:0] bdat_i;
  input  [(-1)+SIZE:0] badr_i;
  input  bwr_i;
  reg  [(-1)+WIDTH:0] ram[(2*(2**SIZE))<<<(-1)-1:0];
  reg  [(-1)+SIZE:0] rd_addr_a;
  reg  [(-1)+SIZE:0] rd_addr_b;
  wire [(-1)+WIDTH:0] adat_o;
  wire [(-1)+WIDTH:0] bdat_o;

  
  always @(posedge aclk_i)
      begin
        if (awr_i == 1'b1) ram[aadr_i] <= adat_i;
          
        rd_addr_a <= aadr_i;
      end
  
  always @(posedge bclk_i)
      begin
        if (bwr_i == 1'b1) ram[badr_i] <= bdat_i;
          
        rd_addr_b <= badr_i;
      end
  assign adat_o = ram[rd_addr_a];
  assign bdat_o = ram[rd_addr_b];
endmodule

