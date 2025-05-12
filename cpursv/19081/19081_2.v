
module reg32(clk,we,din,dout);

  parameter  WIDTH = 32;
  input  we;
  input  clk;
  input  [(0-1)+WIDTH:0] din;
  output [(0-1)+WIDTH:0] dout;
  reg  [(0-1)+WIDTH:0] store;

  
  always @(posedge clk)  if (we) store <= din;
    
  assign dout = store;
endmodule

