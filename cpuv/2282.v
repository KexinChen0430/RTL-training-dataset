module RAMBuffer(
    input wire        RAMread,        
    input wire        RAMZeroData,    
    input wire        InitRAMCode,    
    input wire        WriteString,    
    input wire [7:0]  ramCode,        
    input wire [15:0] ramString,      
    input wire [17:0] ramDicPointer,  
    output reg [15:0] oRAMBuffer      
);
    reg [15:0] RAM [262143:0];
    always @ (*) begin
        if (RAMZeroData)
            RAM[ramDicPointer] = 16'b0;
        else if (InitRAMCode)
            RAM[ramDicPointer] = {8'b0, ramCode};
        else if (WriteString)
            RAM[ramDicPointer] = ramString;
        else if (RAMread)
            oRAMBuffer = RAM[ramDicPointer];
    end
endmodule