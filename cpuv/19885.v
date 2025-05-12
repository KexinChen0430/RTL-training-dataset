module 
Status_state	<= STATE_IDLE; 
else if (FIFOFULL_signal)
	Status_state	<= STATE_FIFOFULL; 
else if (TRAININGDONE_signal)
	Status_state	<= STATE_TRAININGDONE; 
else
	Status_state	<= STATE_IDLE; 
end 
initial
	counter <= 3'b000; 
always@(posedge clk) 
	counter <= counter + 3'b001; 
assign status_out = status_r; 
always@(posedge clk)begin 
	case(Status_state) 
		STATE_RST:
			status_r	<= STR_RST[counter]; 
		STATE_TRAININGDONE:
			status_r	<= STR_TRAININGDONE[counter]; 
		STATE_FIFOFULL:
			status_r	<= STR_FIFOFULL[counter]; 
		STATE_IDLE:
			status_r	<= STR_IDLE[counter]; 
	endcase 
end 
endmodule 