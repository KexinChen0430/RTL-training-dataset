
module raminfr(clk,we,a,dpra,di,dpo);

  parameter  addr_width = 4;
  parameter  data_width = 8;
  parameter  depth = 16;
  input  clk;
  input  we;
  input  [addr_width-1:0] a;
  input  [addr_width-1:0] dpra;
  input  [(0-1)+data_width:0] di;
  output [(0-1)+data_width:0] dpo;
  reg  [(0-1)+data_width:0] ram[(0-1)+depth:0];
  wire [(0-1)+data_width:0] dpo;
  wire [(0-1)+data_width:0] di;
  wire [addr_width-1:0] a;
  wire [addr_width-1:0] dpra;

  
  always @(posedge clk)
      begin
        if (we) ram[a] <= di;
          
      end
  assign dpo = ram[dpra];
endmodule

