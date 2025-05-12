module is not selected or is reset. 
opcode <= 2'b10;   
opcodeReceived <= 0; 
shiftReg <= 0; 
if (TO_DUT_LENGTH > 1) begin 
    shiftReg[TO_DUT_LENGTH-1] <= 1; 
end
bitCounter <= 0; 
activateClk <= 0; 
end
assign clkDut_o = (activateClk == 1 ? !drck1_i : 0); 
assign tdo1_o = (moduleActive == 1 ? shiftReg[0] : 0); 
assign moduleActive = ((id == ID && headerReceived == 1) ? 1 : 0); 
endmodule 