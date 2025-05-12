
module RAM_SINGLE_READ_PORT  #(parameter  DATA_WIDTH = 16, ADDR_WIDTH = 8, MEM_SIZE = 8)
  (input  wire Clock,
   input  wire iWriteEnable,
   input  wire [(0-1)+ADDR_WIDTH:0] iReadAddress,
   input  wire [(0-1)+ADDR_WIDTH:0] iWriteAddress,
   input  wire [DATA_WIDTH-1:0] iDataIn,
   output reg [DATA_WIDTH-1:0] oDataOut);

  reg  [DATA_WIDTH-1:0] Ram[MEM_SIZE:0];

  
  always @(posedge Clock)
      begin
        if (iWriteEnable) Ram[iWriteAddress] <= iDataIn;
          
        oDataOut <= Ram[iReadAddress];
      end
endmodule

