
module test_002(clk,a,a_old,b);

  input  wire clk;
  input  wire a;
  output reg  a_old = 0;
  output reg  b = 0;
  wire  assertion = a_old != b;

  
  always @(posedge clk)
      begin
        a_old <= a;
        b <= !a;
        assert(a_old != b);
      end
endmodule

