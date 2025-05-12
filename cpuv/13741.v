module mbus_int_ctrl
(
  input CLKIN,                         
  input RESETn,                        
  input MBC_ISOLATE,                   
  input SC_CLR_BUSY,                   
  input MBUS_CLR_BUSY,                 
  input REQ_INT,                       
  input MBC_SLEEP,                     
  input LRC_SLEEP,                     
  output reg EXTERNAL_INT_TO_WIRE,     
  output reg EXTERNAL_INT_TO_BUS,      
  input CLR_EXT_INT                    
);
reg clr_busy_temp;
reg BUS_BUSYn;
always @ * begin
  if (MBC_ISOLATE == `IO_HOLD)         
    clr_busy_temp = 0;
  else                                 
    clr_busy_temp = MBUS_CLR_BUSY;
end
wire RESETn_BUSY = ((~clr_busy_temp) & (~SC_CLR_BUSY));
always @ (negedge CLKIN or negedge RESETn or negedge RESETn_BUSY) begin
  if (~RESETn)                         
    BUS_BUSYn <= 1;
  else if (~RESETn_BUSY)               
    BUS_BUSYn <= 1;
  else                                 
    BUS_BUSYn <= 0;
end
wire RESETn_local = (RESETn & CLKIN);
wire RESETn_local2 = (RESETn & (~CLR_EXT_INT));
wire INT_BUSY = (REQ_INT & BUS_BUSYn);
always @ (posedge INT_BUSY or negedge RESETn_local) begin
  if (~RESETn_local)                   
    EXTERNAL_INT_TO_WIRE <= 0;
  else begin
    case ({MBC_SLEEP, LRC_SLEEP})      
      {`IO_HOLD, `IO_HOLD}:            
        begin EXTERNAL_INT_TO_WIRE <= 1; end
      {`IO_RELEASE, `IO_HOLD}:         
        begin if (BUS_BUSYn) EXTERNAL_INT_TO_WIRE <= 1; end
      default:                         
        begin end
    endcase
  end
end
always @ (posedge INT_BUSY or negedge RESETn_local2) begin
  if (~RESETn_local2)                  
    EXTERNAL_INT_TO_BUS <= 0;
  else begin
    case ({MBC_SLEEP, LRC_SLEEP})      
      {`IO_HOLD, `IO_HOLD}:            
        begin EXTERNAL_INT_TO_BUS <= 1; end
      {`IO_RELEASE, `IO_HOLD}:         
        begin if (BUS_BUSYn) EXTERNAL_INT_TO_BUS <= 1; end
      default:                         
        begin end
    endcase
  end
end
endmodule 