module Rx(CLK,reset,cableReset_L,hardReset_L, message_received_for_Phy, CC_Busy, CC_Idle, Start, Unexpected_goodCRC, Tx_state_Machine, Data_from_I2C,
Tx_Message_Discarded,ALERT,RECEIVE_BYTE_COUNT, GoodCRCtoPhy, address, DataToReg);
localparam Rx_Idle = 4'b0000;
localparam Rx_Wait_For_Phy_Message = 4'b0001;
localparam Rx_Message_Discarded = 4'b0010;
localparam Rx_Send_GoodCRC = 4'b0100;
localparam Rx_Report_SOP = 4'b1000;
input wire RECEIVE_DETECT_I;
input wire CLK;
input wire reset;
input wire cableReset_L;
input wire hardReset_L;
input wire message_received_for_Phy;
input wire CC_Busy;
input wire CC_Idle;
input wire Start;
input Unexpected_goodCRC;
input Tx_state_Machine;
input wire [7:0] Data_from_I2C;
output reg Tx_Message_Discarded;
output reg [15:0] ALERT;
output reg  [7:0] RECEIVE_BYTE_COUNT;
output reg GoodCRCtoPhy;
output reg [7:0] address;
output reg [7:0] DataToReg;
reg [7:0] next_address;
reg [7:0] next_RECEIVE_BYTE_COUNT;
reg next_GoodCRCtoPhy;
reg [7:0] next_DATA;
reg [15:0] next_ALERT_OUT;
reg next_Tx_Message_Discarded;
reg[3:0] state;
reg [3:0] next_state;
assign Rx_Reset = !cableReset_L | !hardReset_L;
assign Rx_Buffer_Overflow = ALERT[10];
always@(posedge CLK)
  begin
    if(~reset)
      begin
        state <= Rx_Idle;
        Tx_Message_Discarded <= 0;
        ALERT <= 16'h0000;
        RECEIVE_BYTE_COUNT <= 8'h00;
        GoodCRCtoPhy <= 0;
        address <= 8'h00;
        DataToReg <= 8'h00;
      end
    else
      begin
        state <= next_state;
        Tx_Message_Discarded <= next_Tx_Message_Discarded;
        ALERT <= next_ALERT_OUT;
        RECEIVE_BYTE_COUNT <= next_RECEIVE_BYTE_COUNT;
        GoodCRCtoPhy <= next_GoodCRCtoPhy ;
        address <= next_address;
        DataToReg <= next_DATA;
      end
  end
always@(*)
  begin
    case(state)
      Rx_Idle:
        if(Rx_Reset || ~Start)
          begin
            next_state = Rx_Idle;
          end
        else
          begin
            next_state = Rx_Wait_For_Phy_Message;
          end
      Rx_Wait_For_Phy_Message:
        begin
          if(Rx_Buffer_Overflow)
            begin
              next_state = Rx_Wait_For_Phy_Message;
            end
          else
            if(message_received_for_Phy)
              next_state = Rx_Message_Discarded;
              else
            next_state = Rx_Wait_For_Phy_Message;
      end
      Rx_Message_Discarded:
              begin
                next_state = Unexpected_goodCRC ? Rx_Report_SOP : Rx_Send_GoodCRC ;
              end
      Rx_Send_GoodCRC:
        begin
          if(CC_Busy || CC_Idle)
              begin
                next_state = Rx_Wait_For_Phy_Message;
              end else
                begin
                  next_state = Rx_Report_SOP;
                end
        end
      Rx_Report_SOP:
        next_state = Rx_Wait_For_Phy_Message;
      default:
        next_state = state;
  endcase
end
always @(*)
  begin
    case(state)
      Rx_Message_Discarded:
        begin
        if(Tx_state_Machine)
          begin
            next_Tx_Message_Discarded = 1;
            next_ALERT_OUT = ALERT | 16'h0020;
          end
        end
      Rx_Send_GoodCRC:
        begin
          next_GoodCRCtoPhy = 1;
        end
      Rx_Report_SOP:
        begin
          next_DATA = Data_from_I2C;
          next_RECEIVE_BYTE_COUNT <= RECEIVE_BYTE_COUNT + 1;
          next_address = RECEIVE_BYTE_COUNT + 8'h30;
          if(RECEIVE_BYTE_COUNT == 31)
            begin
              next_ALERT_OUT = ALERT | 16'h0404;
              next_RECEIVE_BYTE_COUNT <= 0;
            end
            else
              begin
                next_ALERT_OUT = ALERT | 16'h0004;
              end
        end
      default:
        begin
          next_address = address;
          next_ALERT_OUT = ALERT;
          next_RECEIVE_BYTE_COUNT = RECEIVE_BYTE_COUNT;
          next_GoodCRCtoPhy= GoodCRCtoPhy;
          next_DATA = DataToReg;
          next_Tx_Message_Discarded = Tx_Message_Discarded;
        end
    endcase
  end
endmodule