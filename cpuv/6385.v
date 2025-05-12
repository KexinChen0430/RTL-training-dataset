module decodeFSM(
    clk, rst, currentRealBit, currentRealBitValid, sectorPulse, prog_empty,
    wordOut, wordOutReady, skipMFMBit, headerOut, headerOutStrobe,
    decode_state, beginWriteNow
);
`include "FSMStates.v"
input  clk; 
input  rst; 
input  currentRealBit; 
input  currentRealBitValid; 
input  sectorPulse; 
input  prog_empty; 
output reg [16:0] wordOut; 
output reg wordOutReady; 
output reg skipMFMBit; 
output reg headerOut; 
output reg headerOutStrobe; 
output reg [2:0] decode_state; 
output reg beginWriteNow; 
reg [11:0] bitCounter; 
reg [5:0] headerbitCounter; 
reg [5:0] preamblebitCounter; 
always @(posedge clk) begin
    if(rst | sectorPulse) begin
        if(sectorPulse) begin
            decode_state <= DSFM_PR1; 
        end else begin
            decode_state <= DSFM_INIT; 
        end
        bitCounter <= 12'b0;
        preamblebitCounter <= 6'b0;
        wordOut <= 17'b0;
        headerOut <= 0;
        headerOutStrobe <= 0;
        headerbitCounter <= 0;
        wordOutReady <= 0;
        skipMFMBit <= 0;
        beginWriteNow <= 0;
    end else begin
        skipMFMBit <= 0;
        case (decode_state)
            DSFM_INIT: begin
            end
            DSFM_PR1: begin
                if(currentRealBitValid) begin
                    if(preamblebitCounter == 31) begin
                        if(currentRealBit == 1) begin
                            skipMFMBit <= 1;
                        end
                    end
                    if(preamblebitCounter < 32) begin
                        preamblebitCounter <= preamblebitCounter + 1'b1;
                    end else if(currentRealBit == 1) begin
                        preamblebitCounter <= 6'b0;
                        if(!prog_empty) begin
                            decode_state <= DSFM_PO2;
                        end else begin
                            decode_state <= DSFM_HDR;
                        end
                    end
                end
            end
            DSFM_HDR: begin
                wordOutReady <= 0;
                headerOutStrobe <= 0;
                if(headerbitCounter < 6'd48) begin
                    if(currentRealBitValid) begin
                        headerbitCounter <= headerbitCounter + 1'b1;
                        headerOut <= currentRealBit;
                        headerOutStrobe <= 1;
                        wordOut <= {1'b0, currentRealBit, wordOut[15:1]};
                        if(headerbitCounter == 6'b001111) begin
                            wordOut <= {1'b1, currentRealBit, wordOut[15:1]};
                        end
                        if((headerbitCounter & 4'b1111) == 4'b1111) begin
                            wordOutReady <= 1;
                        end
                    end
                end else begin
                    headerbitCounter <= 6'b0;
                    decode_state <= DSFM_PO1;
                end
            end
            DSFM_PO1: begin
                if(currentRealBitValid) begin
                    if(headerbitCounter < 16) begin
                        headerbitCounter <= headerbitCounter + 1'b1;
                    end else begin
                        headerbitCounter <= 6'b0;
                        beginWriteNow <= 1;
                        decode_state <= DSFM_IT_IDLE;
                    end
                end
            end
            DSFM_IT_IDLE: begin
                beginWriteNow <= 0;
                decode_state <= DSFM_PR2;
            end
            DSFM_PR2: begin
                if(currentRealBitValid) begin
                    if(preamblebitCounter == 31) begin
                        if(currentRealBit == 1) begin
                            skipMFMBit <= 1;
                        end
                    end
                    if(preamblebitCounter < 32) begin
                        preamblebitCounter <= preamblebitCounter + 1'b1;
                    end else if(currentRealBit == 1) begin
                        preamblebitCounter <= 6'b0;
                        decode_state <= DSFM_DATA;
                    end
                end
            end
            DSFM_DATA: begin
                wordOutReady <= 0;
                if(bitCounter < 12'd2064) begin
                    if(currentRealBitValid) begin
                        bitCounter <= bitCounter + 1'b1;
                        wordOut <= {1'b0, currentRealBit, wordOut[15:1]};
                        if((bitCounter & 4'b1111) == 4'b1111) begin
                            wordOutReady <= 1;
                        end
                    end
                end else begin
                    bitCounter <= 12'b0;
                    decode_state <= DSFM_PO2;
                end
            end
            DSFM_PO2: begin
            end
        endcase
    end
end
endmodule