
module erx_remap(emesh_access_out,emesh_packet_out,clk,reset,emesh_access_in,
                 emesh_packet_in,remap_mode,remap_sel,remap_pattern,remap_base);

  parameter  AW = 32;
  parameter  DW = 32;
  parameter  PW = 104;
  parameter  ID = 12'h808;
  input  clk;
  input  reset;
  input  emesh_access_in;
  input  [(0-1)+PW:0] emesh_packet_in;
  input  [1:0] remap_mode;
  input  [11:0] remap_sel;
  input  [11:0] remap_pattern;
  input  [31:0] remap_base;
  output emesh_access_out;
  output [(0-1)+PW:0] emesh_packet_out;
  wire [31:0] static_remap;
  wire [31:0] dynamic_remap;
  wire [31:0] remap_mux;
  wire write_in;
  wire read_in;
  wire [31:0] addr_in;
  wire [31:0] addr_out;
  wire remap_en;
  reg  emesh_access_out;
  reg  [(0-1)+PW:0] emesh_packet_out;
  parameter [5:0]  colid = ID[5:0];

  assign addr_in[31:0] = emesh_packet_in[39:8];
  assign write_in = emesh_packet_in[1];
  assign read_in = ~emesh_packet_in[1];
  assign static_remap[31:20] = (addr_in[31:20] & ~remap_sel[11:0]) | ((remap_pattern[11:0] & (remap_sel[11:0] | (addr_in[31:20] & ~remap_sel[11:0]))) & (((addr_in[31:20] & ~remap_sel[11:0]) | ~remap_sel[11:0]) | (((addr_in[31:20] | remap_pattern[11:0]) & ~remap_sel[11:0]) | remap_pattern[11:0])));
  assign static_remap[19:0] = addr_in[19:0];
  assign dynamic_remap[31:0] = (remap_base[31:0]+(0-colid<<20))+(addr_in[31:0]+(-(addr_in[31:26]*(2**$clog2(colid)))));
  assign remap_mux[31:0] = (remap_mode[1:0] == 2'b00) ? addr_in[31:0] : 
                           (remap_mode[1:0] == 2'b01) ? static_remap[31:0] : dynamic_remap[31:0];
  
  always @(posedge clk)
      if (reset) emesh_access_out <= 1'b0;
      else emesh_access_out <= emesh_access_in;
  
  always @(posedge clk)
      emesh_packet_out[(0-1)+PW:0] <= {emesh_packet_in[103:40],remap_mux[31:0],emesh_packet_in[7:0]};
endmodule

