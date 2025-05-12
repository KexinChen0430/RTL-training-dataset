module window_ctrl (
  input clock, 
  input reset, 
  input [`SCREEN_X_BITWIDTH:0] buffer_x_pos, 
  input [`SCREEN_Y_BITWIDTH:0] buffer_y_pos, 
  input [`SCREEN_X_BITWIDTH:0] screen_x, 
  input [`SCREEN_Y_BITWIDTH:0] screen_y, 
  output reg shift_up, 
  output reg shift_left, 
  output reg buffer_rdy 
);
always@(posedge clock or negedge reset) begin
  if(reset == 1'b0) begin 
    shift_left <= 1'd0; 
  end else if( screen_x >= buffer_x_pos && 
               screen_x < buffer_x_pos + `SCREEN_X_WIDTH'd`BUFFER_W &&
               screen_y >= buffer_y_pos && 
               screen_y < buffer_y_pos + `SCREEN_Y_WIDTH'd`BUFFER_H
             )
    shift_left <= 1'd1; 
  else
    shift_left <= 1'd0; 
end 
always@(posedge clock or negedge reset) begin
  if(reset == 1'b0) begin 
    shift_up <= 1'd0; 
  end else if (screen_x == buffer_x_pos + `SCREEN_X_WIDTH'd`BUFFER_W && 
               screen_y >= buffer_y_pos && 
               screen_y < buffer_y_pos + `SCREEN_Y_WIDTH'd`BUFFER_H - 1
             )
    shift_up <= 1'd1; 
  else
    shift_up <= 1'd0; 
end 
always@(posedge clock or negedge reset) begin
  if (reset == 1'b0) begin 
    buffer_rdy <= 1'b0; 
  end else if( screen_x == buffer_x_pos + `SCREEN_X_WIDTH'd`BUFFER_W && 
               screen_y == buffer_y_pos + `SCREEN_Y_WIDTH'd`BUFFER_H)
    buffer_rdy <= 1'b1; 
  else
    buffer_rdy <= 1'b0; 
end 
endmodule 