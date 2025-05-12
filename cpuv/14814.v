module x_s3e_dpram (
    input  wire                 clka,  
    input  wire [`SpmAddrBus]  addra, 
    input  wire [`WordDataBus] dina,  
    input  wire                 wea,   
    output reg  [`WordDataBus] douta, 
    input  wire                 clkb,  
    input  wire [`SpmAddrBus]  addrb, 
    input  wire [`WordDataBus] dinb,  
    input  wire                 web,   
    output reg  [`WordDataBus] doutb  
);
    reg [`WordDataBus] mem [0:`SPM_DEPTH-1]; 
    always @(posedge clka) begin
        if ((web == `ENABLE) && (addra == addrb)) begin
            douta   <= #1 dinb; 
        end else begin
            douta   <= #1 mem[addra]; 
        end
        if (wea == `ENABLE) begin
            mem[addra] <= #1 dina; 
        end
    end
    always @(posedge clkb) begin
        if ((wea == `ENABLE) && (addrb == addra)) begin
            doutb   <= #1 dina; 
        end else begin
            doutb   <= #1 mem[addrb]; 
        end
        if (web == `ENABLE) begin
            mem[addrb] <= #1 dinb; 
        end
    end
endmodule