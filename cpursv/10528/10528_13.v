
module jserialaddlab(a,b,clk,reset,sum,carry,cout,count,so);

  input  clk,reset,a,b;
  output sum,carry;
  reg  cin;
  output reg [3:0] so;
  output reg [2:0] count;
  output reg cout;
  wire cut;

  assign sum = ((b & ~a) | ((a & ~b) | (cin & ~((b & ~a) | (a & (~a | (a & ~b))))))) & ((~((b & ~a) | (a & (~a | (a & ~b)))) | (~cin & (~a | (a & ~b)))) & ((b | (a & ~b)) | ~((b & ~a) | (a & (~a | (a & ~b))))));
  assign carry = (count == 3'd4) ? 0 : cut;
  assign cut = ((((b | cin) & a) & b) | (b & cin)) | (cin & a);
  
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
        else count <= (count == 4) ? 1 : (count+1);
      end
endmodule

