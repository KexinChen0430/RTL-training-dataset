
module updowncounterbehavioural(in,clk,rst,out);

  input  wire in,clk,rst;
  output wire [3:0] out;
  reg  [3:0] _out;

  
  initial    _out = 4'b0000;
  
  always @(posedge clk)
      if (rst == 1'b1) _out = 4'b0000;
      else if (in == 1'b1) _out = 1+_out;
      else _out = (-1)+_out;
  assign out = _out;
endmodule

