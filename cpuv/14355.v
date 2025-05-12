module outputs 
assign WrtAdrY = DestReg_Dly2; 
assign WrtEnbY = WE_Y_Dly2;    
assign WrtAdrX = DestReg_Dly1; 
assign WrtEnbX = WE_X_Dly1;    
assign RdAdrA = InstReg[19:16]; 
assign RdAdrB = InstReg[15:12]; 
assign RdAdrC = InstReg[11:8];  
always @ (posedge clock) 
  begin
    if (reset) 
      begin
      InstReg       <= 32'h00000000; 
      DestReg_Dly1  <= 4'h0;         
      DestReg_Dly2  <= 4'h0;         
      WE_Y_Dly1     <= 1'b0;         
      WE_Y_Dly2     <= 1'b0;         
      WE_X_Dly1     <= 1'b0;         
      MemWriteValid <= 1'b0;         
      end
    else 
      begin
      InstReg       <= InstBus;      
      DestReg_Dly1  <= InstReg[23:20]; 
      DestReg_Dly2  <= DestReg_Dly1; 
      WE_Y_Dly1     <= writeY ;      
      WE_Y_Dly2     <= WE_Y_Dly1;    
      WE_X_Dly1     <= writeX;       
      MemWriteValid <= writeMem;     
      end
  end 
wire WrtEnbX, WrtEnbY; 
endmodule 