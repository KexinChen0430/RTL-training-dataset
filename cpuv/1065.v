module do?
    if(curSPIBit == 15) begin
        FIFOReadEnable <= 1;
    end
    compensatedWriteDataToDriveCount <= compensatedWriteDataToDriveCount + 1;
    writeData <= compensatedWriteDataToDrive[15];
    if(compensatedWriteDataToDriveCount == 0) begin
        SPIWriteWordCounter <= SPIWriteWordCounter + 1;
        writeDataPipeline <= {writeDataPipeline[2:0], SPICommandWord[curSPIBit]};
        curSPIBit <= curSPIBit + 1;
        casez (writeDataPipeline)
        endcase
    end else begin
        compensatedWriteDataToDrive <= compensatedWriteDataToDrive << 1;
    end
    if(SPIWriteWordCounter > 133) begin
        SPIWriteWordCounter <= 8'b0;
        FIFOReadEnable <= 0;
        curSPIBit <= 4'b0;
        writeGate <= 0;
        compensatedWriteDataToDrive <= 16'b1111111111111111;
        inhibit_read <= 0;
        cnc_state <= CNC_IDLE;
    end
end
default:
    cnc_state <= CNC_IDLE;
endcase
end
endmodule