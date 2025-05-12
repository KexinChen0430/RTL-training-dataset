module... 
always begin 
  dout = 8'bX; 
  case (MemWrite[1:0]) 
  'b00: dout = T; 
  'b01: dout = AluR; 
  'b10: dout = {P[7:6], 1'b1, !GotInterrupt, P[3:0]}; 
  'b11: dout = State[0] ? PC[7:0] : PC[15:8]; 
  endcase 
  mw = MemWrite[2] && !IsResetInterrupt; 
  mr = !mw; 
end 
always begin 
  case (AddrBus) 
  0: aout = PC; 
  1: aout = AX; 
  2: aout = {8'h01, SP}; 
  3: aout = {13'b1111_1111_1111_1, !IsNMIInterrupt, !IsResetInterrupt, ~State[0]}; 
  endcase 
end 
always @(posedge clk) begin 
  if (reset) begin 
    State <= 0; 
    IR <= 0; 
    GotInterrupt <= 1; 
    IsResetInterrupt <= 1; 
    P <= 'h24; 
    SP <= 0; 
    T <= 0; 
    JumpTaken <= 0; 
  end else if (ce) begin 
    case (LoadSP) 
    0,2,3: SP <= SP + { {7{LoadSP[0]}}, LoadSP[1] }; 
    1: SP <= X; 
    endcase 
    case (LoadT) 
    2: T <= DIN; 
    3: T <= AluIntR; 
    endcase 
    if (FlagCtrl) begin 
      case(FlagsCtrl) 
      0: P <= P;      
      1: {P[0], P[1], P[6], P[7]} <= {CO, ZO, VO, SO}; 
      2: P[2] <= 1;     
      3: P[6] <= 0;     
      4: {P[7:6],P[3:0]} <= {DIN[7:6], DIN[3:0]}; 
      5: P[0] <= IR[5]; 
      6: P[2] <= IR[5]; 
      7: P[3] <= IR[5]; 
      endcase 
    end
    case (DIN[7:5]) 
    0: JumpTaken <= ~P[7]; 
    1: JumpTaken <=  P[7]; 
    2: JumpTaken <= ~P[6]; 
    3: JumpTaken <=  P[6]; 
    4: JumpTaken <= ~P[0]; 
    5: JumpTaken <=  P[0]; 
    6: JumpTaken <= ~P[1]; 
    7: JumpTaken <=  P[1]; 
    endcase 
    if (StateCtrl == 2'b10) begin 
      GotInterrupt <= (irq & ~P[2]) | nmi_active; 
      IsResetInterrupt <= 0; 
    end
    IR <= NextIR; 
    State <= NextState; 
  end 
end 
endmodule 