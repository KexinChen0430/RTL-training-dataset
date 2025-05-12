module frmgen
(
output reg send_data, 
output en_fm0, 
output reg st_enc, 
output pre_p_complete, 
output p_complete, 
output reg fg_complete, 
input clk_frm, 
input rst_for_new_package, 
input reply_data, 
input [15:0]crc_16, 
input [1:0]m, 
input trext, 
input reply_complete, 
input en_crc16_for_rpy 
);