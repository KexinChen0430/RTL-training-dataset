module lookup3(
   output [31:0] x, y, z, 
   output        done,     
   input [31:0]  k0, k1, k2, 
   input         clk,        
   input         en,         
   input         rst,        
   input [31:0]  length      
);
reg [31:0] x, y, z;
reg [4:0] shift;
wire [31:0] OA, OB, OC;
reg [31:0] a, b, c;
mix M0(
   .OA(OA[31:0]),
   .OB(OB[31:0]),
   .OC(OC[31:0]),
   .a(a[31:0]),
   .b(b[31:0]),
   .c(c[31:0]),
   .clk(clk),
   .shift(shift[4:0])
);
reg [2:0] round;
always @(posedge clk)
  if (rst)
    round <= #1 0;       
  else if (en)
    round <= #1 round + 1; 
wire [31:0] length_val = (length << 2) + 32'hdeadbeef;
always @(posedge clk)
  if (en)
    case (round)
      0: begin
         a <= #1 k0 + length_val;
         b <= #1 k1 + length_val;
         c <= #1 k2 + length_val;
         shift <= #1 4;
      end
      1: begin
         a <= #1 OB;
         b <= #1 OC;
         c <= #1 OA;
         shift <= #1 6;
      end
      2: begin
         a <= #1 OB;
         b <= #1 OC;
         c <= #1 OA;
         shift <= #1 8;
      end
      3: begin
         a <= #1 OB;
         b <= #1 OC;
         c <= #1 OA;
         shift <= #1 16;
      end
      4: begin
         a <= #1 OB;
         b <= #1 OC;
         c <= #1 OA;
         shift <= #1 19;
      end
      5: begin
         a <= #1 OB;
         b <= #1 OC;
         c <= #1 OA;
         shift <= #1 4;
      end
    endcase
always @(posedge clk)
  if (round == 6) begin
    x <= #1 OA;
    y <= #1 OB;
    z <= #1 OC;
  end
assign done = round == 7;
endmodule 