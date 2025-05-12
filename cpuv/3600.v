module datamem(dataOut, address, dataIn, readmode, writemode);
    output reg [31:0] dataOut;
    input [31:0] address;
    input [31:0] dataIn;
    input readmode;
    input writemode;
    reg [31:0] dMemory [2499:250];
    always@ (readmode or writemode)
    begin
        if (writemode == 1)
          dMemory[address >> 2]=dataIn; 
        if (readmode == 1)
          dataOut = dMemory[address >> 2]; 
    end
endmodule