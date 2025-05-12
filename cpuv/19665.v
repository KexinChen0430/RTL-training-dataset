module simple (a, b);
input [7:0] a;
output [7:0] b;
reg  b;	
always @(a)
  begin
    b = a;
  end
endmodule