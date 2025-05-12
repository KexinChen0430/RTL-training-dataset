module 
    I2C_FSM_TimerPreset = 1'b1; 
    I2C_FSM_TimerEnable = 1'b0; 
    I2C_FSM_Wr1         = 1'b0; 
    I2C_FSM_Wr0         = 1'b0; 
    case (I2C_FSM_State) 
      stIdle: begin 
        if (QueryLocal_i == 1'b1) 
        begin
          I2C_FSM_NextState = stReqLocWrPtr; 
          I2C_Data_o        = 8'b10011000; 
          I2C_FIFOWrite_o   = 1'b1; 
        end
        else if (QueryRemote_i == 1'b1) 
        begin
          I2C_FSM_NextState = stReqRemWrPtr; 
          I2C_Data_o        = 8'b10011000; 
          I2C_FIFOWrite_o   = 1'b1; 
        end
        else 
        begin
          I2C_Data_o        = 8'b10011000; 
        end
      end
      stReqLocWrPtr: begin 
        I2C_FSM_NextState   = stReqLocStart; 
        I2C_Data_o          = 8'b00000000; 
        I2C_FIFOWrite_o     = 1'b1; 
      end
      stReqLocStart: begin 
        I2C_StartProcess_o  = 1'b1; 
        I2C_FSM_NextState   = stReqLocWait; 
      end
      stReqLocWait: begin 
        if (I2C_Error_i == 1'b1) 
        begin
          I2C_FSM_NextState   = stIdle; 
          Error_o             = 1'b1; 
        end
        else if (I2C_Busy_i == 1'b0) 
        begin
          I2C_FSM_NextState   = stRead; 
        end
      end
      stReqRemWrPtr: begin 
        I2C_FSM_NextState   = stReqRemStart; 
        I2C_Data_o          = 8'b00000001; 
        I2C_FIFOWrite_o     = 1'b1; 
      end
      stReqRemStart: begin 
        I2C_StartProcess_o  = 1'b1; 
        I2C_FSM_NextState   = stReqRemWait; 
      end
      stReqRemWait: begin 
        if (I2C_Error_i == 1'b1) 
        begin
          I2C_FSM_NextState   = stIdle; 
          Error_o             = 1'b1; 
        end
        else if (I2C_Busy_i == 1'b0) 
        begin
          I2C_FSM_NextState   = stRead; 
        end
      end
      stRead: begin 
        I2C_FSM_NextState   = stReadStart; 
        I2C_Data_o          = 8'b10011001; 
        I2C_FIFOWrite_o     = 1'b1; 
      end
      stReadStart: begin 
        I2C_ReceiveSend_n_o = 1'b1; 
        I2C_ReadCount_o     = 8'h02; 
        I2C_StartProcess_o  = 1'b1; 
        I2C_FSM_NextState   = stReadWait; 
      end
      stReadWait: begin 
        I2C_ReceiveSend_n_o = 1'b1; 
        I2C_ReadCount_o     = 8'h02; 
        if (I2C_Busy_i == 1'b0) 
        begin
          I2C_FSM_NextState   = stReadStoreLSB; 
          I2C_FIFOReadNext_o  = 1'b1; 
          I2C_FSM_Wr1         = 1'b1; 
        end
      end
      stReadStoreLSB: begin 
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
endmodule 