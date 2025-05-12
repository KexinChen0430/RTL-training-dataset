module
reg [24-1:0] cfg;
wire bit3;
wire bit2;
wire bit1;
wire bit0;
assign {bit3,bit2,bit1,bit0} = pwm0_i[5:2];
always @(posedge clk_i)
if (rstn_i == 1'b0) begin
   cfg   <=  {CCW{1'b0}};
end else begin
   cfg  <= {~pwm0_i[13],pwm0_i[13-1:6],1'b0,bit3,bit2,bit3,bit1,bit3,bit2,bit3,bit0,bit3,bit2,bit3,bit1,bit3,bit2,bit3};
end
reg [24-1:0] cfg_b;
wire bit3_b;
wire bit2_b;
wire bit1_b;
wire bit0_b;
assign {bit3_b,bit2_b,bit1_b,bit0_b} = pwm1_i[5:2];
always @(posedge clk_i)
if (rstn_i == 1'b0) begin
   cfg_b   <=  {CCW{1'b0}};
end else begin
   cfg_b  <= {~pwm1_i[13],pwm1_i[13-1:6],1'b0,bit3_b,bit2_b,bit3_b,bit1_b,bit3_b,bit2_b,bit3_b,bit0_b,bit3_b,bit2_b,bit3_b,bit1_b,bit3_b,bit2_b,bit3_b};
end
endmodule