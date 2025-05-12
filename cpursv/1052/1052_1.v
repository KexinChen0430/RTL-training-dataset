
module reg_file(input  clk,
                input  regWrite,
                input  [4:0] readReg1,
                input  [4:0] readReg2,
                input  [4:0] writeReg,
                input  [31:0] writeData,
                output reg [31:0] readData1,
                output reg [31:0] readData2);

  reg  [31:0] regFile[31:0];
  integer i;

  
  initial  
  begin
    for (i = 0; i < 32; i = 1+i)
        begin
          regFile[i] <= 0;
        end
  end
  
  always @(readReg1 or readReg2 or regFile)
      begin
        readData1 <= regFile[readReg1];
        readData2 <= regFile[readReg2];
      end
  
  always @(posedge clk)
      begin
        if (regWrite) regFile[writeReg] <= writeData;
          
      end
endmodule

