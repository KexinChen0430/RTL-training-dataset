module
    I2C_FSM_TimerPreset = 1'b1;
    I2C_FSM_TimerEnable = 1'b0;
    I2C_FSM_Wr1         = 1'b0;
    I2C_FSM_Wr0         = 1'b0;
    case (I2C_FSM_State)
      stIdle: begin
        if (Start_i == 1'b1)
        begin
          I2C_FSM_NextState = stWriteReq1;
          I2C_Data_o        = 8'b10010000;
          I2C_FIFOWrite_o   = 1'b1;
        end
        else
        begin
          I2C_Data_o        = 8'b10010000;
        end
      end
      stWriteReq1: begin
        I2C_FSM_NextState   = stWriteReq2;
        I2C_Data_o          = 8'b00000011;
        I2C_FIFOWrite_o     = 1'b1;
      end
      stWriteReq2: begin
        I2C_FSM_NextState   = stStartReq;
        I2C_Data_o          = 8'h20;
        I2C_FIFOWrite_o     = 1'b1;
      end
      stStartReq: begin
        I2C_StartProcess_o  = 1'b1;
        I2C_FSM_NextState   = stWaitReq;
      end
      stWaitReq: begin
        if (I2C_Error_i == 1'b1)
        begin
          I2C_FSM_NextState   = stIdle;
          Error_o             = 1'b1;
        end
        else if (I2C_Busy_i == 1'b0)
        begin
          I2C_FSM_NextState   = stWait;
          I2C_FSM_TimerPreset = 1'b0;
          I2C_FSM_TimerEnable = 1'b1;  
        end
      end
      stWait: begin
        if (I2C_FSM_TimerOvfl == 1'b0)
        begin
          I2C_FSM_TimerPreset = 1'b0;
          I2C_FSM_TimerEnable = 1'b1;  
          I2C_Data_o          = 8'b10010000;
        end
        else
        begin
          I2C_FSM_NextState   = stWriteAddr1;
          I2C_Data_o          = 8'b10010000;
          I2C_FIFOWrite_o     = 1'b1;
        end
      end
      stWriteAddr1: begin
        I2C_FSM_NextState   = stStartAddr;
        I2C_Data_o          = 8'b00000000;
        I2C_FIFOWrite_o     = 1'b1;
      end
      stStartAddr: begin
        I2C_StartProcess_o  = 1'b1;
        I2C_FSM_NextState   = stWaitAddr;
      end
      stWaitAddr: begin
        if (I2C_Busy_i == 1'b0)
        begin
          I2C_FSM_NextState   = stStartQuery;
          I2C_Data_o          = 8'b10010001;   
          I2C_FIFOWrite_o     = 1'b1;
        end
        else
        begin
          I2C_Data_o          = 8'b10010001;   
        end
      end
      stStartQuery: begin
        I2C_ReceiveSend_n_o = 1'b1;
        I2C_ReadCount_o     = 8'h02;
        I2C_StartProcess_o  = 1'b1;
        I2C_FSM_NextState   = stWaitQuery;
      end
      stWaitQuery: begin
        I2C_ReceiveSend_n_o = 1'b1;
        I2C_ReadCount_o     = 8'h02;
        if (I2C_Busy_i == 1'b0)
        begin
          I2C_FSM_NextState   = stRead1;
          I2C_FIFOReadNext_o  = 1'b1;
          I2C_FSM_Wr1         = 1'b1;
        end
      end
      stRead1: begin
        I2C_FIFOReadNext_o  = 1'b1;
        I2C_FSM_Wr0         = 1'b1;
        I2C_FSM_NextState   = stPause;
      end
      stPause: begin
        Done_o              = 1'b1;
        I2C_FSM_NextState   = stIdle;
      end
      default: begin
      end
    endcase
  end
  always @(negedge Reset_n_i or posedge Clk_i)
  begin
    if (!Reset_n_i)
    begin
      Byte0_o <= 8'd0;
      Byte1_o <= 8'd0;
    end
    else
    begin
      if (I2C_FSM_Wr0)
      begin
        Byte0_o <= I2C_Data_i;
      end
      if (I2C_FSM_Wr1)
      begin
        Byte1_o <= I2C_Data_i;
      end
    end
  end
  reg [15:0] I2C_FSM_Timer;
  always @(negedge Reset_n_i or posedge Clk_i)
  begin
    if (!Reset_n_i)
    begin
      I2C_FSM_Timer <= 16'd0;
    end
    else
    begin
      if (I2C_FSM_TimerPreset)
      begin
        I2C_FSM_Timer <= ParamCounterPreset_i;
      end
      else if (I2C_FSM_TimerEnable)
      begin
        I2C_FSM_Timer <= I2C_FSM_Timer - 1'b1;
      end
    end
  end
  assign I2C_FSM_TimerOvfl = (I2C_FSM_Timer == 0) ? 1'b1 : 1'b0;
endmodule