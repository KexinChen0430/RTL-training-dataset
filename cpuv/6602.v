module mc_chroma_filter_hor(
  frac_x,
  frac_y,
  A,
  B,
  C,
  D,
  out
);
input [2:0] frac_x,frac_y;
input [`PIXEL_WIDTH-1:0] A;
input [`PIXEL_WIDTH-1:0] B;
input [`PIXEL_WIDTH-1:0] C;
input [`PIXEL_WIDTH-1:0] D;
output[2*`PIXEL_WIDTH-1:0] out;
reg signed [2*`PIXEL_WIDTH-1:0] sum;
reg        [`PIXEL_WIDTH-1:  0] pel_out; 
wire signed [2*`PIXEL_WIDTH-1:0] val_out; 
always @(*) begin
  case(frac_x)
    'd0:  sum = (B*64);
    'd1:  sum = B*58 + C*10 - ((A + D) *2);
    'd2:  sum = B*54 + C*16 - ((A*2 + D) *2);
    'd3:  sum = B*46 + C*28 - (A*6 + D*4);
    'd4:  sum = 36*(B+C) - ((A+D)*4);
    'd5:  sum = C*46 + 28*B - (D*6 + A*4);
    'd6:  sum = C*54 + B*16 - (D*4 + A*2);
    'd7:  sum = C*58 + B*10 - ((A + D) *2);
  endcase
end
assign val_out = sum - 'd8192;
always @(*) begin
  if (((sum+'d32) >> 6) < 0)
    pel_out = 'd0;
  else if (((sum+'d32) >> 6) > 255)begin
    pel_out = 'd255;
  end
  else begin
    pel_out = (sum+'d32) >> 6;
  end
end
assign out = (frac_x == 0 || frac_y == 0 ) ? {{`PIXEL_WIDTH{1'b0}}, pel_out} : val_out;
endmodule