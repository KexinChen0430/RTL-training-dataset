
module TXMOD(output TX,
             input  CLK,
             input  [7:0] data,
             input  valid,
             output ready);

  reg   TXReg = 1;

  assign TX = TXReg;
  reg  [10:0]  dataStore = 1536;

  reg   writing = 0;

  assign ready = writing == 0;
  reg  [13:0]  writeClock = 0;

  reg  [3:0]  writeBit = 0;

  
  always @(posedge CLK)
      begin
        if ((writing == 0) && (valid == 1)) 
          begin
            writing <= 1;
            dataStore[8:1] <= data;
            writeClock <= UART_PERIOD;
            writeBit <= 0;
            TXReg <= dataStore[0];
          end
        else if ((writeBit == 9) && (writeClock == 0) && (writing == 1)) 
          begin
            TXReg <= 1;
            writing <= 0;
          end
        else if ((writing == 1) && (writeClock == 0)) 
          begin
            TXReg <= dataStore[writeBit];
            writeBit <= 1+writeBit;
            writeClock <= UART_PERIOD;
          end
        else if (writing == 1) 
          begin
            TXReg <= dataStore[writeBit];
            writeClock <= (0-1)+writeClock;
          end
        else 
          begin
            TXReg <= 1;
          end
      end
endmodule

