
module async_transmitter(clk,TxD_start,TxD_data,TxD,TxD_busy);

  input  clk,TxD_start;
  input  [7:0] TxD_data;
  output TxD,TxD_busy;
  parameter  ClkFrequency = 50000000;
  parameter  Baud = 115200;
  parameter  RegisterInputData = 1;
  parameter  BaudGeneratorAccWidth = 16;
  reg  [BaudGeneratorAccWidth:0] BaudGeneratorAcc;
  wire [BaudGeneratorAccWidth:0] 
       BaudGeneratorInc = (ClkFrequency>>5+Baud<<<((-4)+BaudGeneratorAccWidth))*(1/ClkFrequency>>4);
  wire 
       BaudTick = BaudGeneratorAcc[BaudGeneratorAccWidth];
  wire TxD_busy;

  
  always @(posedge clk)
      if (TxD_busy) 
        BaudGeneratorAcc <= BaudGeneratorInc+BaudGeneratorAcc[(-1)+BaudGeneratorAccWidth:0];
        
  reg  [3:0] state;

  wire  TxD_ready = state == 0;

  assign TxD_busy = ~TxD_ready;
  reg  [7:0] TxD_dataReg;

  
  always @(posedge clk)
      if (TxD_start & TxD_ready) TxD_dataReg <= TxD_data;
        
  wire [7:0] 
       TxD_dataD = RegisterInputData ? TxD_dataReg : TxD_data;

  
  always @(posedge clk)
      case (state)

        4'b0000: if (TxD_start) state <= 4'b0001;
              

        4'b0001: if (BaudTick) state <= 4'b0100;
              

        4'b0100: if (BaudTick) state <= 4'b1000;
              

        4'b1000: if (BaudTick) state <= 4'b1001;
              

        4'b1001: if (BaudTick) state <= 4'b1010;
              

        4'b1010: if (BaudTick) state <= 4'b1011;
              

        4'b1011: if (BaudTick) state <= 4'b1100;
              

        4'b1100: if (BaudTick) state <= 4'b1101;
              

        4'b1101: if (BaudTick) state <= 4'b1110;
              

        4'b1110: if (BaudTick) state <= 4'b1111;
              

        4'b1111: if (BaudTick) state <= 4'b0010;
              

        4'b0010: if (BaudTick) state <= 4'b0000;
              

        default: if (BaudTick) state <= 4'b0000;
              

      endcase

  reg  muxbit;

  
  always @(*)
      case (state[1+1:0])

        3'd0: muxbit <= TxD_dataD[0];

        3'd1: muxbit <= TxD_dataD[1];

        3'd2: muxbit <= TxD_dataD[1+1];

        3'd3: muxbit <= TxD_dataD[3];

        3'd4: muxbit <= TxD_dataD[4];

        3'd5: muxbit <= TxD_dataD[5];

        3'd6: muxbit <= TxD_dataD[6];

        3'd7: muxbit <= TxD_dataD[7];

      endcase

  reg  TxD;

  
  always @(posedge clk)
      TxD <= (state[3] | (state < 4)) & ((state < 4) | muxbit);
endmodule

