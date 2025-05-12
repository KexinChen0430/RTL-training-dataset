module trial(
    clock,
    a,
    out
);
parameter NUM_BITS = 5;
input clock;
input [NUM_BITS-1:0] a;
output out;
wire [NUM_BITS-1:0] a;
wire clock;
reg [NUM_BITS-1:0] out;
reg [3:0] remain;
reg [3:0] bits = NUM_BITS;
reg [3:0] shift = 4'h0;
reg [NUM_BITS-1:0] b;
reg [4:0] r1;
reg [3:0] store000 = 4'h0;
reg [3:0] store001 = 4'h0;
reg [3:0] store010 = 4'h0;
reg [3:0] store100 = 4'h0;
reg [3:0] store101 = 4'h0;
reg [3:0] store110 = 4'h0;
reg count = 1'b0;
reg [4:0] VAL1 = 5'h10;
reg [4:0] VAL2 = 5'h12;
reg [4:0] VAL3 = 5'h18;
reg [4:0] VAL4 = 5'h1B;
reg [3:0] exp1 = 4'h00;
reg [3:0] exp2 = 4'h03;
reg [3:0] exp3 = 4'h01;
reg [3:0] exp4 = 4'h04;
always@(posedge clock)
begin
  if(count == 1'b0)
  begin
    b <= a;
    remain <= NUM_BITS-1;
  end
  count <= 1'b1;
end
always@(posedge clock)
begin
  if(count == 1'b1)
  begin
  end
end
always@(b)
begin
end
endmodule