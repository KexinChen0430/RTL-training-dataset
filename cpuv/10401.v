module data_memory(memclock_in, address, writeData, memWrite, memRead, readData);
    input memclock_in;          
    input [31:0] address;       
    input [31:0] writeData;     
    input memWrite;             
    input memRead;              
    output [31:0] readData;     
    reg [31:0] memFile[0:127];  
    reg [31:0] readData;        
    integer i;                  
    initial
    begin
        memFile[0] = 32'h00000000;
        memFile[31] = 32'h0000001f;
    end
    always @ (memRead or address or memWrite)
    begin
        readData = memFile[address];
    end
    always @ (negedge memclock_in)
    begin
        if(memWrite)
            memFile[address] = writeData;
    end
endmodule