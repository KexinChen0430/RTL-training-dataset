module RAMB16_RIGEL(
    WEA,    
    ENA,    
    SSRA,   
    CLKA,   
    ADDRA,  
    DIPA,   
    DIA,    
    DOA,    
    DIB,    
    DOB,    
    WEB,    
    ENB,    
    SSRB,   
    CLKB,   
    ADDRB,  
    DIPB    
);
parameter WRITE_MODE_A = "write_first";
parameter WRITE_MODE_B = "write_first";
parameter INIT_00=256'd0;
parameter INIT_3F=256'd0;
parameter BITS=1;
input WEA, ENA, SSRA, CLKA;
input [13-$clog2(BITS):0] ADDRA; 
input [((BITS<8?8:BITS)/8)-1:0] DIPA; 
input [BITS-1:0] DIA;
output [BITS-1:0] DOA;
input [BITS-1:0] DIB;
output [BITS-1:0] DOB;
input WEB, ENB, SSRB, CLKB;
input [13-$clog2(BITS):0] ADDRB;
input [((BITS<8?8:BITS)/8)-1:0] DIPB; 
reg [BITS-1:0] ram [(2048*8)/BITS-1:0];
reg [BITS-1:0] bufferA;
reg [BITS-1:0] bufferB;
reg [16383:0] initpacked = {INIT_3F, INIT_3E, , INIT_01, INIT_00};
reg [31:0] i=0;
reg [31:0] j=0;
initial begin
    for(i=0; i<(2048*8)/BITS-1; i=i+1) begin
        for(j=0; j<BITS; j=j+1) begin
            ram[i][j] = initpacked[i*BITS+j];
        end
    end
end
assign DOA = bufferA;
assign DOB = bufferB;
always @(posedge CLKA or posedge CLKB) begin
    if( CLKA && CLKB && ENA && ENB && WEA && WEB ) begin
        if(ADDRA==ADDRB) begin
            $display("ERROR: write to some address on both ports");
        end else begin
            bufferA <= ram[ADDRA];
            bufferB <= ram[ADDRB];
            ram[ADDRA] <= DIA;
            ram[ADDRB] <= DIB;
        end
    end else begin
        if (CLKA && ENA) begin
            if (WEA) begin
                ram[ADDRA] <= DIA;
                bufferA <= ram[ADDRA];
            end else begin
                bufferA <= ram[ADDRA];
            end
        end
        if (CLKB && ENB) begin
            if (WEB) begin
                ram[ADDRB] <= DIB;
                bufferB <= ram[ADDRB];
            end else begin
                bufferB <= ram[ADDRB];
            end
        end
    end
end
endmodule