
module reg32(clk,we,din,dout);

  parameter  WIDTH = 32;
  input  we;
  input  clk;
  input  [WIDTH+(0-1):0] din;
  output [WIDTH+(0-1):0] dout;
  reg  [WIDTH+(0-1):0] store;

  
  always @(posedge clk)  if (we) store <= din;
    
  assign dout = store;
endmodule

