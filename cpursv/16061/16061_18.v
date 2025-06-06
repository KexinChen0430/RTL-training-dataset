
module SensorFSM  #(parameter  DataWidth = 8)
  (input  Reset_n_i,
   input  Clk_i,
   input  Enable_i,
   output reg CpuIntr_o,
   output [(-1)+(DataWidth*1<<1):0] SensorValue_o,
   output reg MeasureFSM_Start_o,
   input  MeasureFSM_Done_i,
   input  [DataWidth+(-1):0] MeasureFSM_Byte0_i,
   input  [DataWidth+(-1):0] MeasureFSM_Byte1_i,
   input  [(-1)+(DataWidth*1<<1):0] ParamThreshold_i,
   input  [(-1)+(DataWidth*1<<1):0] ParamCounterPreset_i);

  localparam  stDisabled = 2'b00;
  localparam  stIdle = 2'b01;
  localparam  stXfer = 2'b10;
  localparam  stNotify = 2'b11;
  reg  [1:0] SensorFSM_State;
  reg  [1:0] SensorFSM_NextState;
  wire SensorFSM_TimerOvfl;
  reg  SensorFSM_TimerPreset;
  reg  SensorFSM_TimerEnable;
  wire SensorFSM_DiffTooLarge;
  reg  SensorFSM_StoreNewValue;
  wire [(-1)+(DataWidth*1<<1):0] SensorValue;
  reg  [(-1)+(DataWidth*1<<1):0] Word0;
  wire [(-1)+(DataWidth*1<<1):0] AbsDiffResult;

  
  always @(negedge Reset_n_i or posedge Clk_i)
      begin
        if (!Reset_n_i) 
          begin
            SensorFSM_State <= stDisabled;
          end
        else 
          begin
            SensorFSM_State <= SensorFSM_NextState;
          end
      end
  
  always @(SensorFSM_State or Enable_i or SensorFSM_TimerOvfl or MeasureFSM_Done_i or SensorFSM_DiffTooLarge)
      begin
        SensorFSM_NextState = SensorFSM_State;
        SensorFSM_TimerPreset = 1'b0;
        SensorFSM_TimerEnable = 1'b0;
        MeasureFSM_Start_o = 1'b0;
        SensorFSM_StoreNewValue = 1'b0;
        CpuIntr_o = 1'b0;
        case (SensorFSM_State)

          stDisabled: begin
                if (Enable_i == 1'b1) 
                  begin
                    SensorFSM_TimerPreset = 1'b1;
                    SensorFSM_NextState = stIdle;
                  end
                  
              end

          stIdle: begin
                if (Enable_i == 1'b0) 
                  begin
                    SensorFSM_NextState = stDisabled;
                  end
                else if (SensorFSM_TimerOvfl == 1'b1) 
                  begin
                    SensorFSM_NextState = stXfer;
                    MeasureFSM_Start_o = 1'b1;
                  end
                else 
                  begin
                    SensorFSM_TimerEnable = 1'b1;
                  end
              end

          stXfer: begin
                if (MeasureFSM_Done_i == 1'b1) 
                  begin
                    SensorFSM_TimerPreset = 1'b1;
                    if (SensorFSM_DiffTooLarge == 1'b1) 
                      begin
                        SensorFSM_NextState = stNotify;
                        SensorFSM_StoreNewValue = 1'b1;
                      end
                    else 
                      begin
                        SensorFSM_NextState = stIdle;
                      end
                  end
                  
              end

          stNotify: begin
                SensorFSM_TimerEnable = 1'b1;
                SensorFSM_NextState = stIdle;
                CpuIntr_o = 1'b1;
              end

          default: begin

              end

        endcase

      end
  reg  [(-1)+(DataWidth*1<<1):0] SensorFSM_Timer;

  
  always @(negedge Reset_n_i or posedge Clk_i)
      begin
        if (!Reset_n_i) 
          begin
            SensorFSM_Timer <= 16'd0;
          end
        else 
          begin
            if (SensorFSM_TimerPreset) 
              begin
                SensorFSM_Timer <= ParamCounterPreset_i;
              end
            else if (SensorFSM_TimerEnable) 
              begin
                SensorFSM_Timer <= SensorFSM_Timer-1'b1;
              end
              
          end
      end
  assign SensorFSM_TimerOvfl = (SensorFSM_Timer == 0) ? 1'b1 : 1'b0;
  assign SensorValue = {MeasureFSM_Byte1_i,MeasureFSM_Byte0_i};
  
  always @(negedge Reset_n_i or posedge Clk_i)
      begin
        if (!Reset_n_i) 
          begin
            Word0 <= 16'd0;
          end
        else 
          begin
            if (SensorFSM_StoreNewValue) 
              begin
                Word0 <= SensorValue;
              end
              
          end
      end
  wire [DataWidth*1<<1:0] DiffAB;

  wire [(-1)+(DataWidth*1<<1):0] DiffBA;

  assign DiffAB = (0-{1'b0,Word0})+{1'b0,SensorValue};
  assign DiffBA = Word0+(-SensorValue);
  assign AbsDiffResult = DiffAB[DataWidth*1<<1] ? DiffBA : DiffAB[(-1)+(DataWidth*1<<1):0];
  assign SensorFSM_DiffTooLarge = (AbsDiffResult > ParamThreshold_i) ? 1'b1 : 1'b0;
  assign SensorValue_o = Word0;
endmodule

