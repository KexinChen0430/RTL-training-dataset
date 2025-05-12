module UartCtrlTx (
  input  [2:0] io_configFrame_dataLength, 
  input  `UartStopType_defaultEncoding_type io_configFrame_stop, 
  input  `UartParityType_defaultEncoding_type io_configFrame_parity, 
  input   io_samplingTick, 
  input   io_write_valid, 
  output reg  io_write_ready, 
  input  [7:0] io_write_payload, 
  output  io_txd, 
  input   io_mainClk, 
  input   resetCtrl_systemReset); 
wire  _zz_1_;
wire [0:0] _zz_2_;
wire [2:0] _zz_3_;
wire [0:0] _zz_4_;
wire [2:0] _zz_5_;
reg  clockDivider_counter_willIncrement;
wire  clockDivider_counter_willClear;
reg [2:0] clockDivider_counter_valueNext;
reg [2:0] clockDivider_counter_value;
wire  clockDivider_counter_willOverflowIfInc;
wire  clockDivider_willOverflow;
reg [2:0] tickCounter_value;
reg `UartCtrlTxState_defaultEncoding_type stateMachine_state;
reg  stateMachine_parity;
reg  stateMachine_txd;
reg  stateMachine_txd_regNext;
assign _zz_1_ = (tickCounter_value == io_configFrame_dataLength);
assign _zz_2_ = clockDivider_counter_willIncrement;
assign _zz_3_ = {2'd0, _zz_2_};
assign _zz_4_ = ((io_configFrame_stop == `UartStopType_defaultEncoding_ONE) ? (1'b0) : (1'b1));
assign _zz_5_ = {2'd0, _zz_4_};
always @ (*) begin
  clockDivider_counter_willIncrement = 1'b0;
  if(io_samplingTick)begin
    clockDivider_counter_willIncrement = 1'b1;
  end
end
assign clockDivider_counter_willClear = 1'b0;
assign clockDivider_counter_willOverflowIfInc = (clockDivider_counter_value == (3'b100));
assign clockDivider_willOverflow = (clockDivider_counter_willOverflowIfInc && clockDivider_counter_willIncrement);
always @ (*) begin
  if(clockDivider_willOverflow)begin
    clockDivider_counter_valueNext = (3'b000);
  end else begin
    clockDivider_counter_valueNext = (clockDivider_counter_value + _zz_3_);
  end
  if(clockDivider_counter_willClear)begin
    clockDivider_counter_valueNext = (3'b000);
  end
end
always @ (*) begin
  stateMachine_txd = 1'b1; 
  io_write_ready = 1'b0; 
  case(stateMachine_state) 
    `UartCtrlTxState_defaultEncoding_IDLE : begin
    end
    `UartCtrlTxState_defaultEncoding_START : begin
      stateMachine_txd = 1'b0;
    end
    `UartCtrlTxState_defaultEncoding_DATA : begin
      stateMachine_txd = io_write_payload[tickCounter_value];
      if(clockDivider_willOverflow)begin
        if(_zz_1_)begin
          io_write_ready = 1'b1;
        end
      end
    end
    `UartCtrlTxState_defaultEncoding_PARITY : begin
      stateMachine_txd = stateMachine_parity;
    end
    default : begin
    end
  endcase
end
assign io_txd = stateMachine_txd_regNext;
always @ (posedge io_mainClk or posedge resetCtrl_systemReset) begin
  if (resetCtrl_systemReset) begin
    clockDivider_counter_value <= (3'b000);
    stateMachine_state <= `UartCtrlTxState_defaultEncoding_IDLE;
    stateMachine_txd_regNext <= 1'b1;
  end else begin
    clockDivider_counter_value <= clockDivider_counter_valueNext;
    case(stateMachine_state)
      `UartCtrlTxState_defaultEncoding_IDLE : begin
        if((io_write_valid && clockDivider_willOverflow))begin
          stateMachine_state <= `UartCtrlTxState_defaultEncoding_START;
        end
      end
      `UartCtrlTxState_defaultEncoding_START : begin
        if(clockDivider_willOverflow)begin
          stateMachine_state <= `UartCtrlTxState_defaultEncoding_DATA;
        end
      end
      `UartCtrlTxState_defaultEncoding_DATA : begin
        if(clockDivider_willOverflow)begin
          if(_zz_1_)begin
            if((io_configFrame_parity == `UartParityType_defaultEncoding_NONE))begin
              stateMachine_state <= `UartCtrlTxState_defaultEncoding_STOP;
            end else begin
              stateMachine_state <= `UartCtrlTxState_defaultEncoding_PARITY;
            end
          end
        end
      end
      `UartCtrlTxState_defaultEncoding_PARITY : begin
        if(clockDivider_willOverflow)begin
          stateMachine_state <= `UartCtrlTxState_defaultEncoding_STOP;
        end
      end
      default : begin
        if(clockDivider_willOverflow)begin
          if((tickCounter_value == _zz_5_))begin
            stateMachine_state <= (io_write_valid ? `UartCtrlTxState_defaultEncoding_START : `UartCtrlTxState_defaultEncoding_IDLE);
          end
        end
      end
    endcase
    stateMachine_txd_regNext <= stateMachine_txd;
  end
end
always @ (posedge io_mainClk) begin
  if(clockDivider_willOverflow)begin
    tickCounter_value <= (tickCounter_value + (3'b001));
  end
  if(clockDivider_willOverflow)begin
    stateMachine_parity <= (stateMachine_parity ^ stateMachine_txd);
  end
  case(stateMachine_state)
    `UartCtrlTxState_defaultEncoding_IDLE : begin
    end
    `UartCtrlTxState_defaultEncoding_START : begin
      if(clockDivider_willOverflow)begin
        stateMachine_parity <= (io_configFrame_parity == `UartParityType_defaultEncoding_ODD);
        tickCounter_value <= (3'b000);
      end
    end
    `UartCtrlTxState_defaultEncoding_DATA : begin
      if(clockDivider_willOverflow)begin
        if(_zz_1_)begin
          tickCounter_value <= (3'b000);
        end
      end
    end
    `UartCtrlTxState_defaultEncoding_PARITY : begin
      if(clockDivider_willOverflow)begin
        tickCounter_value <= (3'b000);
      end
    end
    default : begin
    end
  endcase
end
endmodule