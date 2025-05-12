module UartCtrlTx (
    input  [2:0] io_configFrame_dataLength, 
    input  `UartStopType_binary_sequancial_type io_configFrame_stop, 
    input  `UartParityType_binary_sequancial_type io_configFrame_parity, 
    input   io_samplingTick, 
    input   io_write_valid, 
    output reg  io_write_ready, 
    input  [7:0] io_write_payload, 
    output  io_txd, 
    input   io_mainClk, 
    input   resetCtrl_systemReset 
);
wire  _zz_2; 
wire [0:0] _zz_3; 
wire [2:0] _zz_4; 
wire [0:0] _zz_5; 
wire [2:0] _zz_6; 
reg  clockDivider_counter_willIncrement; 
wire  clockDivider_counter_willClear; 
reg [2:0] clockDivider_counter_valueNext; 
reg [2:0] clockDivider_counter_value; 
wire  clockDivider_counter_willOverflowIfInc; 
wire  clockDivider_tick; 
reg [2:0] tickCounter_value; 
reg `UartCtrlTxState_binary_sequancial_type stateMachine_state; 
reg  stateMachine_parity; 
reg  stateMachine_txd; 
reg  _zz_1; 
assign _zz_2 = (tickCounter_value == io_configFrame_dataLength);
assign _zz_3 = clockDivider_counter_willIncrement;
assign _zz_4 = {2'd0, _zz_3};
assign _zz_5 = ((io_configFrame_stop == `UartStopType_binary_sequancial_ONE) ? (1'b0) : (1'b1));
assign _zz_6 = {2'd0, _zz_5};
always @ (*) begin
    clockDivider_counter_willIncrement = 1'b0;
    if(io_samplingTick)begin
        clockDivider_counter_willIncrement = 1'b1;
    end
end
assign clockDivider_counter_willClear = 1'b0; 
assign clockDivider_counter_willOverflowIfInc = (clockDivider_counter_value == (3'b100));
assign clockDivider_tick = (clockDivider_counter_willOverflowIfInc && clockDivider_counter_willIncrement);
always @ (*) begin
    if(clockDivider_tick)begin
        clockDivider_counter_valueNext = (3'b000);
    end else begin
        clockDivider_counter_valueNext = (clockDivider_counter_value + _zz_4);
    end
    if(clockDivider_counter_willClear)begin
        clockDivider_counter_valueNext = (3'b000);
    end
end
always @ (*) begin
    stateMachine_txd = 1'b1; 
    io_write_ready = 1'b0; 
    case(stateMachine_state)
        `UartCtrlTxState_binary_sequancial_IDLE : begin
        end
        `UartCtrlTxState_binary_sequancial_START : begin
            stateMachine_txd = 1'b0; 
        end
        `UartCtrlTxState_binary_sequancial_DATA : begin
            stateMachine_txd = io_write_payload[tickCounter_value]; 
            if(clockDivider_tick)begin
                if(_zz_2)begin
                    io_write_ready = 1'b1; 
                end
            end
        end
        `UartCtrlTxState_binary_sequancial_PARITY : begin
            stateMachine_txd = stateMachine_parity; 
        end
        default : begin
        end
    endcase
end
assign io_txd = _zz_1;
always @ (posedge io_mainClk or posedge resetCtrl_systemReset) begin
    if (resetCtrl_systemReset) begin
        clockDivider_counter_value <= (3'b000);
        stateMachine_state <= `UartCtrlTxState_binary_sequancial_IDLE;
        _zz_1 <= 1'b1;
    end else begin
        clockDivider_counter_value <= clockDivider_counter_valueNext;
        case(stateMachine_state)
            `UartCtrlTxState_binary_sequancial_IDLE : begin
                if((io_write_valid && clockDivider_tick))begin
                    stateMachine_state <= `UartCtrlTxState_binary_sequancial_START;
                end
            end
            `UartCtrlTxState_binary_sequancial_START : begin
                if(clockDivider_tick)begin
                    stateMachine_state <= `UartCtrlTxState_binary_sequancial_DATA;
                end
            end
            `UartCtrlTxState_binary_sequancial_DATA : begin
                if(clockDivider_tick)begin
                    if(_zz_2)begin
                        if((io_configFrame_parity == `UartParityType_binary_sequancial_NONE))begin
                            stateMachine_state <= `UartCtrlTxState_binary_sequancial_STOP;
                        end else begin
                            stateMachine_state <= `UartCtrlTxState_binary_sequancial_PARITY;
                        end
                    end
                end
            end
            `UartCtrlTxState_binary_sequancial_PARITY : begin
                if(clockDivider_tick)begin
                    stateMachine_state <= `UartCtrlTxState_binary_sequancial_STOP;
                end
            end
            default : begin
                if(clockDivider_tick)begin
                    if((tickCounter_value == _zz_6))begin
                        stateMachine_state <= (io_write_valid ? `UartCtrlTxState_binary_sequancial_START : `UartCtrlTxState_binary_sequancial_IDLE);
                    end
                end
            end
        endcase
        _zz_1 <= stateMachine_txd; 
    end
end
always @ (posedge io_mainClk) begin
    if(clockDivider_tick)begin
        tickCounter_value <= (tickCounter_value + (3'b001)); 
    end
    if(clockDivider_tick)begin
        stateMachine_parity <= (stateMachine_parity ^ stateMachine_txd); 
    end
    case(stateMachine_state)
        `UartCtrlTxState_binary_sequancial_IDLE : begin
        end
        `UartCtrlTxState_binary_sequancial_START : begin
            if(clockDivider_tick)begin
                stateMachine_parity <= (io_configFrame_parity == `UartParityType_binary_sequancial_ODD); 
                tickCounter_value <= (3'b000); 
            end
        end
        `UartCtrlTxState_binary_sequancial_DATA : begin
            if(clockDivider_tick)begin
                if(_zz_2)begin
                    tickCounter_value <= (3'b000); 
                end
            end
        end
        `UartCtrlTxState_binary_sequancial_PARITY : begin
            if(clockDivider_tick)begin
                tickCounter_value <= (3'b000); 
            end
        end
        default : begin
        end
    endcase
end
endmodule