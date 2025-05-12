module pulls_down_the_SDA_bus; 
  wire busIsBusy; 
  reg [7:0] addrDataBuff; 
  reg started = 0, stopped = 0; 
  assign busIsBusy = started ^ stopped; 
  reg startId; 
  always @(negedge SDA) begin
    if (SCK == 1 & !busIsBusy)
      started <= ~started; 
  end
  always @(posedge SDA) begin
    if (SCK == 1 & busIsBusy) begin
      stopped <= ~stopped; 
    end
  end
  always @(negedge SCK) begin
    if (busIsBusy) begin
      case (eventCounter)
        initialState:
          eventCounter <= getAddr; 
        isItMe:
          if (addrDataBuff == moduleAddress) begin
            sda_ack <= 1; 
            eventCounter <= ackSent; 
          end else begin
            eventCounter <= notMe; 
            startId <= started; 
          end
        dataRecv: begin
          sda_ack <= 1; 
          PWM_INTERFACE <= addrDataBuff; 
          eventCounter <= postSend; 
        end
        notMe:
          if (startId != started)
            eventCounter <= getAddr; 
        default: begin
          sda_ack <= 0; 
          if (eventCounter == postSend)
            eventCounter <= initialState; 
          else if (eventCounter != notMe)
            eventCounter <= eventCounter + 1; 
        end
      endcase
    end
  end
  always @(posedge SCK) begin
    if (busIsBusy) begin
      if ((eventCounter > initialState & eventCounter < ackSent) | (eventCounter > ackSent & eventCounter < postSend))
        addrDataBuff <= {addrDataBuff[6:0], SDA}; 
    end
  end
endmodule