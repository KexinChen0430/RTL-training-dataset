module is not selected or is reset.
        opcode <= 2'b10;   
        opcodeReceived <= 0;
        shiftReg <= 0;
        shiftReg[DATA_WIDTH-1] <= 1;
        bitCounter <= 0;
        addrFromHost <= 0;
        addrFromHost[ADDR_WIDTH-1] <= 1;
        addrFromHostReceived <= 0;
        writeToMem             <= 0;
        readFromMem            <= 0;
        dataFromMemReceived    <= 0;
      end
   end
   assign wr_o = writeToMem;
   assign rd_o = readFromMem;
   assign addr_o = addrFromHost;
   assign tdo1_o = (moduleActive == 1) ? shiftReg[0] : 0;
   assign moduleActive = (id == ID && headerReceived == 1) ? 1 : 0;
endmodule