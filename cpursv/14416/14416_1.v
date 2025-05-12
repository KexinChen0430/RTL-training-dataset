
module MP_rf_LUT_RAM(clk,we,wa,ra1,ra2,di,do1,do2);

  parameter  depth = 31;
  parameter  width = 31;
  parameter  addr_width = 5;
  input  clk;
  input  we;
  input  [addr_width-1:0] wa;
  input  [addr_width-1:0] ra1;
  input  [addr_width-1:0] ra2;
  input  [(0-1)+width:0] di;
  output [(0-1)+width:0] do1;
  output [(0-1)+width:0] do2;
  reg  [(0-1)+width:0] ram[depth-1:0];

  
  always @(posedge clk)
      begin
        if (we) ram[wa] <= di;
          
      end
  assign do1 = ram[ra1];
  assign do2 = ram[ra2];
endmodule

