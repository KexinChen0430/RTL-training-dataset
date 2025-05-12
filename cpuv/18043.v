module window_selector(
  input clock, 
  input reset, 
  input [`BUFFER_OUT_VECTOR_BITWIDTH:0] buffer_vector, 
  input [`X_COORD_BITWIDTH:0] x, 
  input [`Y_COORD_BITWIDTH:0] y, 
  output reg[`CAMERA_PIXEL_BITWIDTH:0] value_out 
);
wire [`CAMERA_PIXEL_BITWIDTH:0] buffer_wire [`BUFFER_BW:0][`BUFFER_BH:0];
reg[`CAMERA_PIXEL_BITWIDTH:0] width_selector_wire [`BUFFER_BH:0];
genvar j;
genvar i;
generate
for (j=0; j<`BUFFER_H; j=j+1) begin : buffer_height_loop
  for(i=0; i<`BUFFER_W; i=i+1) begin : buffer_width_loop
    assign buffer_wire[i][j] = buffer_vector[
    (`CAMERA_PIXEL_WIDTH*i)+(`BUFFER_W*`CAMERA_PIXEL_WIDTH*j) +`CAMERA_PIXEL_BITWIDTH:
    (`CAMERA_PIXEL_WIDTH*i)+(`BUFFER_W*`CAMERA_PIXEL_WIDTH*j)
    ];
  end 
end 
endgenerate
genvar m;
generate
for (m=0; m<`BUFFER_H; m=m+1) begin : width_selector
  always@(*) begin 
    case(x) 
      `X_COORD_WIDTH'd0: width_selector_wire[m] = buffer_wire[0][m];
      `X_COORD_WIDTH'd27: width_selector_wire[m] = buffer_wire[27][m];
      default: width_selector_wire[m] = `CAMERA_PIXEL_WIDTH'd0; 
    endcase
  end 
end 
endgenerate
always@(*) begin
  case(y) 
    `Y_COORD_WIDTH'd0: value_out = width_selector_wire[0];
    `Y_COORD_WIDTH'd27: value_out = width_selector_wire[27];
    default: value_out = `CAMERA_PIXEL_WIDTH'd0; 
  endcase
end 
endmodule 