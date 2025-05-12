
module raminfr(clk,we,a,dpra,di,dpo);

  parameter  addr_width = 4;
  parameter  data_width = 8;
  parameter  depth = 16;
  input  clk;
  input  we;
  input  [(-1)+addr_width:0] a;
  input  [(-1)+addr_width:0] dpra;
  input  [data_width+(-1):0] di;
  output [data_width+(-1):0] dpo;
  reg  [data_width+(-1):0] ram[depth+(-1):0];
  wire [data_width+(-1):0] dpo;
  wire [data_width+(-1):0] di;
  wire [(-1)+addr_width:0] a;
  wire [(-1)+addr_width:0] dpra;

  
  always @(posedge clk)
      begin
        if (we) ram[a] <= di;
          
      end
  assign dpo = ram[dpra];
endmodule

