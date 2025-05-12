
module ram_dp8(aclk_i,aadr_i,adat_i,awr_i,adat_o,bclk_i,badr_i,bdat_i,bwr_i,
               bdat_o);

  parameter [31:0]  WIDTH = 8;
  parameter [31:0]  SIZE = 14;
  input  aclk_i;
  output [WIDTH-1:0] adat_o;
  input  [WIDTH-1:0] adat_i;
  input  [SIZE+(-1):0] aadr_i;
  input  awr_i;
  input  bclk_i;
  output [WIDTH-1:0] bdat_o;
  input  [WIDTH-1:0] bdat_i;
  input  [SIZE+(-1):0] badr_i;
  input  bwr_i;
  reg  [WIDTH-1:0] ram[(-1)+(1<<1*1<<(SIZE+(-1))):0];
  reg  [SIZE+(-1):0] rd_addr_a;
  reg  [SIZE+(-1):0] rd_addr_b;
  wire [WIDTH-1:0] adat_o;
  wire [WIDTH-1:0] bdat_o;

  
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

