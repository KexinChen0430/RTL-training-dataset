module mc_chroma_filter_ver( 
  frac_x,
  frac_y,
  A,
  B,
  C,
  D,
  out
);
input [2:0] frac_x,frac_y; 
input signed [2*`PIXEL_WIDTH-1:0] A; 
input signed [2*`PIXEL_WIDTH-1:0] B; 
input signed [2*`PIXEL_WIDTH-1:0] C; 
input signed [2*`PIXEL_WIDTH-1:0] D; 
output reg [`PIXEL_WIDTH-1:0] out; 
reg signed [4*`PIXEL_WIDTH-1:0] sum; 
wire signed [2*`PIXEL_WIDTH-1:0] clip; 
wire signed [2*`PIXEL_WIDTH-1:0] val, pel; 
always @(*) begin 
  case(frac_y) 
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
assign val = (sum + 'd526336) >> 12; 
assign pel = (sum + 'd32) >> 6; 
assign clip = (frac_x == 0) ? pel : val; 
always @(*) begin 
  if (clip < 0) 
    out = 'd0; 
  else if (clip > 255)begin 
    out = 'd255; 
  end
  else begin 
    out = clip; 
  end
end
endmodule