module camera_serial_command_generator
(
  init_camera,          
  take_photo,           
  stop_photo,           
  sys_clk_50,           
  rst,                  
  tx_busy,              
  rx_data,              
  rx_done,              
  tx_data,              
  tx_en,                
  busy,                 
  cmd_gen_state_debug,  
  counter_debug,        
  rx_data_debug         
);
`define idle_state 4'b0000
`define init_camera_amd_state 4'b0001
`define init_camera_amd_ack_state 4'b0010
`define init_camera_acn_state 4'b0011
`define init_camera_acn_ack_state 4'b0100
`define init_camera_act_i_state 4'b0101
`define init_camera_act_i_ack_state 4'b0110
`define init_camera_act_s_state 4'b0111
`define init_camera_act_s_ack_state 4'b1000
input init_camera;
input take_photo;
input stop_photo;
input sys_clk_50;
input rst;
input tx_busy;
output [7:0] tx_data;
output tx_en;
input [7:0] rx_data;
input rx_done;
output busy;
output [4:0] cmd_gen_state_debug;
output [3:0] counter_debug;
output [7:0] rx_data_debug;
reg [3:0] cmd_gen_state;
reg [3:0] cmd_gen_state_next;
reg [3:0] counter;
reg [3:0] counter_next;
wire [7:0] init_camera_amd [0:`init_camera_amd_cnt-1];
assign init_camera_amd[0] = "A";
assign init_camera_amd[1] = "M";
assign init_camera_amd[2] = "D";
assign init_camera_amd[3] = " ";
assign init_camera_amd[4] = "N";
assign init_camera_amd[5] = "\r"; 
wire [7:0] init_camera_acn [0:`init_camera_acn_cnt-1];
assign init_camera_acn[0] = "A";
assign init_camera_acn[1] = "C";
assign init_camera_acn[2] = "N";
assign init_camera_acn[3] = " ";
assign init_camera_acn[4] = "1";
assign init_camera_acn[5] = "\r"; 
wire [7:0] init_camera_act_i [0:`init_camera_act_i_cnt-1];
assign init_camera_act_i[0] = "A";
assign init_camera_act_i[1] = "C";
assign init_camera_act_i[2] = "T";
assign init_camera_act_i[3] = " ";
assign init_camera_act_i[4] = "I";
assign init_camera_act_i[5] = "\r"; 
wire [7:0] init_camera_act_s [0:`init_camera_act_s_cnt-1];
assign init_camera_act_s[0] = "A";
assign init_camera_act_s[1] = "C";
assign init_camera_act_s[2] = "T";
assign init_camera_act_s[3] = " ";
assign init_camera_act_s[4] = "S";
assign init_camera_act_s[5] = "\r"; 
reg busy_reg;
reg [7:0] tx_data_reg;
reg tx_en_reg; 
(* KEEP = "TRUE" *) reg [7:0] rx_data_reg; 
assign rx_data_debug = rx_data_reg;
assign cmd_gen_state_debug = {camera_initiated_reg, cmd_gen_state};
assign counter_debug = counter;
always@(posedge sys_clk_50) begin
  if(rst) begin
    init_camera_reg <= 1'b0;
    take_photo_reg <= 1'b0;
    stop_photo_reg <= 1'b0;
    cmd_gen_state <= `idle_state;
    counter <= 4'd0;
    camera_initiated_reg <= 1'b0;
    tx_busy_reg <= 1'b0;
    rx_data_reg <= 8'd0;
  end
  else begin
    init_camera_reg <= init_camera;
    take_photo_reg <= take_photo;
    stop_photo_reg <= stop_photo;
    cmd_gen_state <= cmd_gen_state_next;
    counter <= counter_next;
    camera_initiated_reg <= camera_initiated_reg_next;
    tx_busy_reg <= tx_busy;
    if(rx_done) begin
      rx_data_reg <= rx_data; 
    end
  end
end
always@(*) begin
  cmd_gen_state_next <= cmd_gen_state;
  busy_reg <= 1'b0;
  counter_next <= counter;
  tx_data_reg <= 8'd0;
  tx_en_reg <= 1'b0;
  camera_initiated_reg_next <= camera_initiated_reg;
  if(cmd_gen_state != `idle_state) begin
    busy_reg <= 1'b1;
  end
  case(cmd_gen_state)
    `idle_state: begin
      counter_next <= 4'd0;
      if(~init_camera_reg & init_camera) begin
        cmd_gen_state_next <= `init_camera_amd_state;
      end
      else if(~take_photo_reg & take_photo) begin
        cmd_gen_state_next <= `init_camera_act_i_state;
      end
      else if(~stop_photo_reg & stop_photo) begin
        cmd_gen_state_next <= `init_camera_act_s_state;
      end
    end
  endcase
end
assign busy = busy_reg;
assign tx_data = tx_data_reg;
assign tx_en = tx_en_reg;
endmodule