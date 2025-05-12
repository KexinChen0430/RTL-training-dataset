
module Registers(input  wire clock,
                 input  wire reset,
                 input  wire [4:0] ReadAddressA,
                 output reg [31:0] ReadDataA,
                 input  wire [4:0] ReadAddressB,
                 output reg [31:0] ReadDataB,
                 input  wire WriteEnable,
                 input  wire [4:0] WriteAddress,
                 input  wire [31:0] WriteData);

  reg  [31:0] data[0:31];
  integer k;

  
  always @(posedge clock or ReadAddressA or ReadAddressB)
      begin
        ReadDataA = data[ReadAddressA];
        ReadDataB = data[ReadAddressB];
      end
  
  always @(negedge reset)
      for (k = 0; k < 32; k = 1+k)
          data[k] = 0;
  
  always @(negedge clock)
      if (reset && WriteEnable) 
        begin
          data[WriteAddress] <= WriteData;
          $display(Registers:);
          $display("\twrote data %2d to register %2d at time %3d\n",
                   WriteData,WriteAddress,$time);
        end
        
endmodule

