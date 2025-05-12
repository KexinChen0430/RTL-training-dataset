module
I2C_FSM_TimerPreset = 1'b1;
I2C_FSM_TimerEnable = 1'b0;
I2C_FSM_Wr1         = 1'b0;
I2C_FSM_Wr0         = 1'b0;
case (I2C_FSM_State)
stIdle: begin
stWriteReq1: begin
stWriteReq2: begin
stStartReq: begin
stWaitReq: begin
stWait: begin
stWriteAddr1: begin
stStartAddr: begin
stWaitAddr: begin
stStartQuery: begin
stWaitQuery: begin
stRead1: begin
stPause: begin
default: begin
endcase
always @(negedge Reset_n_i or posedge Clk_i)
Byte0_o <= 8'd0;
Byte1_o <= 8'd0;
Byte0_o <= I2C_Data_i;
Byte1_o <= I2C_Data_i;
I2C_FSM_Timer <= 32'd0;
I2C_FSM_Timer <= {ParamCounterPresetH_i, ParamCounterPresetL_i};
I2C_FSM_Timer <= I2C_FSM_Timer - 1'b1;
assign I2C_FSM_TimerOvfl = (I2C_FSM_Timer == 0) ? 1'b1 : 1'b0;
endmodule