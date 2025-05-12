module DmcChan(input clk, input ce, input reset,
               input odd_or_even,
               input [2:0] Addr,
               input [7:0] DIN,
               input MW,
               output [6:0] Sample,
               output DmaReq,          
               input DmaAck,           
               output [15:0] DmaAddr,  
               input [7:0] DmaData,    
               output Irq,
               output IsDmcActive);
  reg IrqEnable;
  reg IrqActive;
  reg Loop;                 
  reg [3:0] Freq;           
  reg [6:0] Dac = 0;        
  reg [7:0] SampleAddress;  
  reg [7:0] SampleLen;      
  reg [7:0] ShiftReg;       
  reg [8:0] Cycles;         
  reg [14:0] Address;        
  reg [11:0] BytesLeft;      
  reg [2:0] BitsUsed;        
  reg [7:0] SampleBuffer;    
  reg HasSampleBuffer;       
  reg HasShiftReg;           
  reg [8:0] NewPeriod[0:15];
  reg DmcEnabled;
  reg [1:0] ActivationDelay;
  assign DmaAddr = {1'b1, Address};
  assign Sample = Dac;
  assign Irq = IrqActive;
  assign IsDmcActive = DmcEnabled;
  assign DmaReq = !HasSampleBuffer && DmcEnabled && !ActivationDelay[0];
  initial begin
    NewPeriod[0] = 428;
    NewPeriod[1] = 380;
    NewPeriod[2] = 340;
    NewPeriod[3] = 320;
    NewPeriod[4] = 286;
    NewPeriod[5] = 254;
    NewPeriod[6] = 226;
    NewPeriod[7] = 214;
    NewPeriod[8] = 190;
    NewPeriod[9] = 160;
    NewPeriod[10] = 142;
    NewPeriod[11] = 128;
    NewPeriod[12] = 106;
    NewPeriod[13] = 84;
    NewPeriod[14] = 72;
    NewPeriod[15] = 54;
  end
  always @(posedge clk) begin
    if (reset) begin
      IrqEnable <= 0;
      IrqActive <= 0;
      Loop <= 0;
      Freq <= 0;
      Dac <= 0;
      SampleAddress <= 0;
      SampleLen <= 0;
      ShiftReg <= 8'hff;
      Cycles <= 439;
      Address <= 0;
      BytesLeft <= 0;
      BitsUsed <= 0;
      SampleBuffer <= 0;
      HasSampleBuffer <= 0;
      HasShiftReg <= 0;
      DmcEnabled <= 0;
      ActivationDelay <= 0;
    end else if (ce) begin
      if (ActivationDelay == 3 && !odd_or_even) ActivationDelay <= 1;
      if (ActivationDelay == 1) ActivationDelay <= 0;
      if (MW) begin
        case (Addr)
        0: begin  
            IrqEnable <= DIN[7];
            Loop <= DIN[6];
            Freq <= DIN[3:0];
            if (!DIN[7]) IrqActive <= 0;
          end
        1: begin  
            Dac <= DIN[6:0];
          end
        2: begin  
            SampleAddress <= DIN[7:0];
          end
        3: begin  
            SampleLen <= DIN[7:0];
          end
        5: begin 
            IrqActive <= 0;
            DmcEnabled <= DIN[4];
            if (DIN[4] && !DmcEnabled) begin
              Address <= {1'b1, SampleAddress, 6'b000000};
              BytesLeft <= {SampleLen, 4'b0000};
              ActivationDelay <= 3;
            end
          end
        endcase
      end
      Cycles <= Cycles - 1;
      if (Cycles == 1) begin
        Cycles <= NewPeriod[Freq];
        if (HasShiftReg) begin
          if (ShiftReg[0]) begin
            Dac[6:1] <= (Dac[6:1] != 6'b111111) ? Dac[6:1] + 6'b000001 : Dac[6:1];
          end else begin
            Dac[6:1] <= (Dac[6:1] != 6'b000000) ? Dac[6:1] + 6'b111111 : Dac[6:1];
          end
        end
        ShiftReg <= {1'b0, ShiftReg[7:1]};
        BitsUsed <= BitsUsed + 1;
        if (BitsUsed == 7) begin
          HasShiftReg <= HasSampleBuffer;
          ShiftReg <= SampleBuffer;
          HasSampleBuffer <= 0;
        end
      end
      if (DmaAck) begin
        Address <= Address + 1;
        BytesLeft <= BytesLeft - 1;
        HasSampleBuffer <= 1;
        SampleBuffer <= DmaData;
        if (BytesLeft == 0) begin
          Address <= {1'b1, SampleAddress, 6'b000000};
          BytesLeft <= {SampleLen, 4'b0000};
          DmcEnabled <= Loop;
          if (!Loop && IrqEnable)
            IrqActive <= 1;
        end
      end
    end
  end
endmodule