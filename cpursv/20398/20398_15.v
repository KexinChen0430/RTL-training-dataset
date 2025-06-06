
module f1_test(in,out,clk,reset);

  input  in,reset;
  output reg out;
  input  clk;
  reg  signed  [3:0] a;
  reg  signed  [3:0] b;
  reg  signed  [3:0] c;
  reg  [5:0] d;
  reg  [5:0] e;

  
  always @(clk or reset)
      begin
        a = -4;
        b = 2;
        c = b+a;
        d = b+(a+c);
        d = d**2;
        if (b) e = d**2;
        else e = d*2;
      end
endmodule

