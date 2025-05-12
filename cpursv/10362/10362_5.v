
module dff_s(din,clk,q,se,si,so);

  parameter  SIZE = 1;
  input  [SIZE+(0-1):0] din;
  input  clk;
  output [SIZE+(0-1):0] q;
  input  se;
  input  [SIZE+(0-1):0] si;
  output [SIZE+(0-1):0] so;
  reg  [SIZE+(0-1):0] q;

  
  always @(posedge clk)
      q[SIZE+(0-1):0] <= se ? si[SIZE+(0-1):0] : din[SIZE+(0-1):0];
  assign so[SIZE+(0-1):0] = q[SIZE+(0-1):0];
endmodule

