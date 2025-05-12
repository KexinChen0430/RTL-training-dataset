module I2C_Controller ( 
    input CLOCK, 
    input RESET, 
    input [31:0] I2C_DATA, 
    input GO, 
    output I2C_SCLK, 
    inout I2C_SDAT, 
    output reg END, 
    output ACK 
);
reg SDO; 
reg SCLK; 
reg [31:0]SD; 
reg [6:0]SD_COUNTER; 
assign I2C_SCLK = SCLK | ( ((SD_COUNTER >= 4) & (SD_COUNTER <= 39))? ~CLOCK : 1'b0);
assign I2C_SDAT = SDO ? 1'bz : 1'b0;
reg ACK1,ACK2,ACK3,ACK4; 
assign ACK = ACK1 | ACK2 |ACK3 |ACK4;
always @(negedge RESET or posedge CLOCK ) begin
    if (!RESET) SD_COUNTER=6'b111111; 
    else begin
        if (GO==0)
            SD_COUNTER=0; 
        else
            if (SD_COUNTER < 41) SD_COUNTER[6:0] = SD_COUNTER[6:0] + 7'd1; 
    end
end
always @(negedge RESET or  posedge CLOCK ) begin
    if (!RESET) begin SCLK=1;SDO=1; ACK1=0;ACK2=0;ACK3=0;ACK4=0; END=1; end 
    else
        case (SD_COUNTER) 
        endcase
end
endmodule