module RF(
    i_op             ,
    i_rsk            ,
    i_rf_in          ,
    i_rf_final       ,
    o_rf_out
);
input        i_op           ; 
input[31:0]  i_rsk          ; 
input[63:0]  i_rf_in        ; 
input        i_rf_final     ; 
output[63:0] o_rf_out       ; 
wire[63:0]  w_rf_out     ; 
wire[7:0]  w_rf_out7     ; 
wire[7:0]  w_rf_out6     ; 
wire[7:0]  w_rf_out5     ; 
wire[7:0]  w_rf_out4     ; 
wire[7:0]  w_rf_out3     ; 
wire[7:0]  w_rf_out2     ; 
wire[7:0]  w_rf_out1     ; 
wire[7:0]  w_rf_out0     ; 
wire[7:0] w_f0_6   ; 
wire[7:0] w_f1_4   ; 
wire[7:0] w_f0_2   ; 
wire[7:0] w_f1_0   ; 
wire[7:0] w_rf_mv[0:3]; 
assign w_f0_6 = {i_rf_in[54:48],i_rf_in[55]}    ^
                {i_rf_in[53:48],i_rf_in[55:54]} ^
                {i_rf_in[48]   ,i_rf_in[55:49]};
assign w_f1_4 = {i_rf_in[36:32],i_rf_in[39:37]} ^
                {i_rf_in[35:32],i_rf_in[39:36]} ^
                {i_rf_in[33:32],i_rf_in[39:34]};
assign w_f0_2 = {i_rf_in[22:16],i_rf_in[23]}    ^
                {i_rf_in[21:16],i_rf_in[23:22]} ^
                {i_rf_in[16]   ,i_rf_in[23:17]};
assign w_f1_0 = {i_rf_in[4:0]  ,i_rf_in[7:5]} ^
                {i_rf_in[3:0]  ,i_rf_in[7:4]} ^
                {i_rf_in[1:0]  ,i_rf_in[7:2]};
assign w_rf_mv[3] = (i_op == 0) ? i_rf_in[63:56] ^ (w_f0_6 + i_rsk[31:24]):
                                  i_rf_in[63:56] ^ (w_f0_6 + i_rsk[7:0]);
assign w_rf_mv[2] = (i_op == 0) ? i_rf_in[47:40] + (w_f1_4 ^ i_rsk[23:16]):
                                  i_rf_in[47:40] - (w_f1_4 ^ i_rsk[15:8]);
assign w_rf_mv[1] = (i_op == 0) ? i_rf_in[31:24] ^ (w_f0_2 + i_rsk[15:8]):
                                  i_rf_in[31:24] ^ (w_f0_2 + i_rsk[23:16]);
assign w_rf_mv[0] = (i_op == 0) ? i_rf_in[15:8] + (w_f1_0 ^ i_rsk[7:0]):
                                  i_rf_in[15:8] - (w_f1_0 ^ i_rsk[31:24]);
assign w_rf_out7 = (i_rf_final == 1) ? w_rf_mv[3] :
                                      (i_op == 0) ? i_rf_in[55:48] :
                                                    i_rf_in[7:0];
assign w_rf_out6 = (i_rf_final == 1) ? i_rf_in[55:48] :
                                      (i_op == 0) ? w_rf_mv[2] :
                                                    w_rf_mv[3];
assign w_rf_out5 = (i_rf_final == 1) ? w_rf_mv[2] :
                                      (i_op == 0) ? i_rf_in[39:32] :
                                                    i_rf_in[55:48];
assign w_rf_out4 = (i_rf_final == 1) ? i_rf_in[39:32] :
                                      (i_op == 0) ? w_rf_mv[1] :
                                                    w_rf_mv[2];
assign w_rf_out3 = (i_rf_final == 1) ? w_rf_mv[1] :
                                      (i_op == 0) ? i_rf_in[23:16] :
                                                    i_rf_in[39:32];
assign w_rf_out2 = (i_rf_final == 1) ? i_rf_in[23:16] :
                                      (i_op == 0) ? w_rf_mv[0] :
                                                    w_rf_mv[1];
assign w_rf_out1 = (i_rf_final == 1) ? w_rf_mv[0] :
                                      (i_op == 0) ? i_rf_in[7:0] :
                                                    i_rf_in[23:16];
assign w_rf_out0 = (i_rf_final == 1) ? i_rf_in[7:0] :
                                      (i_op == 0) ? w_rf_mv[3] :
                                                    w_rf_mv[0];
assign w_rf_out = {w_rf_out7, w_rf_out6, w_rf_out5, w_rf_out4, w_rf_out3, w_rf_out2, w_rf_out1, w_rf_out0};
assign o_rf_out = w_rf_out;
endmodule