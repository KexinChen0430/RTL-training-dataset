
module raminfr(clk,we,a,dpra,di,dpo);

  parameter  addr_width = 4;
  parameter  data_width = 8;
  parameter  depth = 16;
  input  clk;
  input  we;
  input  [addr_width+(-1):0] a;
  input  [addr_width+(-1):0] dpra;
  input  [(-1)+data_width:0] di;
  output [(-1)+data_width:0] dpo;
  reg  [(-1)+data_width:0] ram[depth+(-1):0];
  wire [(-1)+data_width:0] dpo;
  wire [(-1)+data_width:0] di;
  wire [addr_width+(-1):0] a;
  wire [addr_width+(-1):0] dpra;

  
  always @(posedge clk)
      begin
        if (we) ram[a] <= di;
          
      end
  assign dpo = ram[dpra];
endmodule

