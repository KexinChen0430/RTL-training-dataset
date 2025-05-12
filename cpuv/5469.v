module DbCPortStatMachine
(
input wire clock , 
input wire DCI   , 
input wire CSC   , 
input wire PLC   , 
input wire PRC   , 
input wire DCE   , 
input wire PED   , 
input wire CEC   , 
input wire Reset_rcvd, 
input wire set_config_succesful, 
input wire EnumError, 
input wire Deconfigure 
);
reg [4:0] rstate; 
reg [4:0] rNew_state; 
always @ (posedge clock)
begin : FSM_SEQ
  if (DCE == 1'b0) begin
    rstate = #1 `DBC_OFF; 
  end else begin
    rstate = #1 rNew_state; 
  end
end
always @ (posedge clock)
begin
if (DCE == 1'b0) begin
  rNew_state = `DBC_OFF; 
end else
	case(rstate)
		`DBC_OFF 		 : if (DCE == 1'b1) begin
			                rNew_state = `DBC_DISCONNECTED; 
			             end else begin
                		rNew_state = `DBC_OFF; 
                		end
	    `DBC_DISCONNECTED : if (DCE == 1'b0) begin
   						rNew_state = `DBC_OFF; 
					end else if (CSC == 1'b1) begin
                		rNew_state = `DBC_ENABLED; 
            		     end else begin
            		    rNew_state = `DBC_DISCONNECTED; 
            		    	 end
        `DBC_DISABLED     : if (DCE == 1'b0) begin
   						rNew_state = `DBC_OFF; 
   						end else if (CSC == 1'b1) begin
                		rNew_state = `DBC_DISCONNECTED; 
                		end else if (PED == 1'b1) begin
                		rNew_state = `DBC_ENABLED; 
                		 end else begin
            		    rNew_state = `DBC_DISABLED; 
            		    	 end
        `DBC_ENABLED 	 : 	 if (DCE == 1'b0) begin
   						rNew_state = `DBC_OFF; 
   						end else if (CSC == 1'b1) begin
                		rNew_state = `DBC_DISCONNECTED; 
                		end else if (PED == 1'b0) begin
                		rNew_state = `DBC_DISABLED; 
   						end else if (CEC == 1'b1 || PLC == 1'b1) begin
                		rNew_state = `DBC_DISABLED; 
                		end else if (EnumError == 1'b1) begin
                		rNew_state = `DBC_ERROR; 
                		end else if (Reset_rcvd == 1'b1) begin
                		rNew_state = `DBC_RESETTING; 
                		end else if (set_config_succesful == 1'b1) begin
                		rNew_state = `DBC_CONFIURED; 
                		end else begin
                		rNew_state = `DBC_ENABLED; 
                		end
        `DBC_RESETTING 	 : 	 if (DCE == 1'b0) begin
   						rNew_state = `DBC_OFF; 
   						end else if (CSC == 1'b1) begin
                		rNew_state = `DBC_DISCONNECTED; 
                		end else if (PED == 1'b0) begin
                		rNew_state = `DBC_DISABLED; 
                		end else if (PRC == 1'b1) begin
                		rNew_state = `DBC_ENABLED; 
                		end  else begin
                		rNew_state = `DBC_OFF; 
                		end
        `DBC_ERROR 		 :	 if (DCE == 1'b0) begin
   						rNew_state = `DBC_OFF; 
   						end else if (CSC == 1'b1) begin
                		rNew_state = `DBC_DISCONNECTED; 
                		end else if (PED == 1'b0) begin
                		rNew_state = `DBC_DISABLED; 
                		end else if (Reset_rcvd == 1'b1) begin
                		rNew_state = `DBC_RESETTING; 
                		end else begin
                		rNew_state = `DBC_ERROR; 
                		end
        `DBC_CONFIURED   : if (DCE == 1'b0) begin
   						rNew_state = `DBC_OFF; 
   						end else if (CSC == 1'b1) begin
                		rNew_state = `DBC_DISCONNECTED; 
                		end else if (PED == 1'b0) begin
                		rNew_state = `DBC_DISABLED; 
                		end else if (Reset_rcvd == 1'b1) begin
                		rNew_state = `DBC_RESETTING; 
                		end else if (Deconfigure == 1'b1) begin
                		rNew_state = `DBC_ENABLED; 
                		end else begin
                		rNew_state = `DBC_CONFIURED; 
                		end
      default : rNew_state = `DBC_OFF; 
	endcase
end
endmodule