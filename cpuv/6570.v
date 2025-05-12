module uart_rx(
    input clk,          
    input rst,          
    input rxd,          
    output [7:0] data_rx, 
    output busy         
);
reg [8:0] rxdata;          
assign data_rx[7:0] = rxdata[8:1]; 
reg busy_reg;               
assign busy = busy_reg;     
reg [9:0] bitTmr;           
reg [3:0] bitIndex;         
reg rxState;                
reg [9:0] bitCnt_0;         
reg [9:0] bitCnt_1;         
always@(posedge clk) begin
    if(rst) 
        begin
            rxState  <= `IDLE; 
            busy_reg <= 0;     
        end
    else 
        begin
            case(rxState) 
                `IDLE : 
                    begin
                        bitIndex <= 0; 
                        bitTmr   <= 0; 
                        bitCnt_0 <= 0; 
                        bitCnt_1 <= 0; 
                        if( rxd == 0 ) 
                            begin
                                rxState <= `RECV_BIT; 
                            end
                        else
                            rxState <= `IDLE; 
                    end
                `RECV_BIT : 
                    begin
                        if (bitTmr == `BIT_TMR_MAX-1) 
                            begin
                                bitTmr   <= 0; 
                                bitCnt_0 <= 0; 
                                bitCnt_1 <= 0; 
                                if (bitIndex == 4'd9-1) 
                                    begin
                                        busy_reg <= 1; 
                                        rxState <= `IDLE; 
                                    end
                                else
                                    begin
                                        busy_reg <= 0; 
                                        bitIndex <= bitIndex + 1'b1; 
                                        rxState <= `RECV_BIT; 
                                    end
                            end
                        else
                            begin
                                if(rxd == 0) 
                                    bitCnt_0 <= bitCnt_0 + 1'b1; 
                                else
                                    bitCnt_1 <= bitCnt_1 + 1'b1; 
                                if( bitCnt_0 > bitCnt_1 ) 
                                    rxdata[bitIndex] <= 0; 
                                else
                                    rxdata[bitIndex] <= 1; 
                                bitTmr <= bitTmr + 1'b1; 
                                rxState <= `RECV_BIT; 
                            end
                    end
                default : 
                    begin
                        rxState  <= `IDLE; 
                        busy_reg <= 0;     
                    end
            endcase
        end
end
endmodule