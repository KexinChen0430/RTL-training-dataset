
module jserialaddlab(a,b,clk,reset,sum,carry,cout,count,so);

  input  clk,reset,a,b;
  output sum,carry;
  reg  cin;
  output reg [3:0] so;
  output reg [2:0] count;
  output reg cout;
  wire cut;

  assign sum = (((a | b) | cin) & (cin | ((~cin & ~a) | (~cin & (a & ~b))))) & ((((~cin & ~a) | (~cin & (a & ~b))) | ~((a | b) & (~a | ~b))) & (~((a | b) & (~a | ~b)) | (a | b)));
  assign carry = (count == 3'd4) ? 0 : cut;
  assign cut = (((b | cin) & (cin | a)) & a) | (cin & b);
  
  always @(posedge clk)
      begin
        if (reset) cin <= 0;
        else cin <= carry;
      end
  
  always @(posedge clk)
      begin
        if (reset) cout <= 0;
        else count <= cut;
      end
  
  always @(posedge clk)
      begin
        if (reset) so <= 0;
        else so <= {sum,so[3:1]};
      end
  
  always @(posedge clk)
      begin
        if (reset) count <= 0;
        else count <= (count == 4) ? 1 : (1+count);
      end
endmodule

