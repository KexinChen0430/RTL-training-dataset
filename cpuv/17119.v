module register(clock_in, readReg1, readReg2, writeReg, writeData, regWrite, rst, readData1, readData2, led, switch, PC);
    input clock_in; 
    input [25:21] readReg1; 
    input [20:16] readReg2; 
    input [4:0] writeReg; 
    input [31:0] writeData; 
    input regWrite; 
    input rst; 
    input [31:0] PC; 
    input [1:0] switch; 
    output [31:0] readData1; 
    output [31:0] readData2; 
    output reg[7:0] led; 
    reg[31:0] regFile[31:0]; 
    reg[31:0] readData1; 
    reg[31:0] readData2; 
    integer i; 
    initial
    begin
        for (i = 0; i < 32; i = i + 1)
            regFile[i] = i;
    end
    always @ (readReg1 or readReg2 or regWrite or writeReg or switch)
    begin
        readData1 = regFile[readReg1]; 
        readData2 = regFile[readReg2]; 
        case(switch)
            0: led[7:0] = PC[7:0]; 
            1: led[7:0] = regFile[1][7:0]; 
            2: led[7:0] = regFile[2][7:0]; 
            3: led[7:0] = regFile[3][7:0]; 
        endcase
    end
    always @ (negedge clock_in)
    begin
        if(rst) 
        begin
            for(i = 0; i < 32; i = i + 1)
                regFile[i] = 0;
        end
        else if(regWrite) 
        begin
            regFile[writeReg] = writeData;
        end
    end
endmodule