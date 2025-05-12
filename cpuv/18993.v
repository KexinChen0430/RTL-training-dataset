module ConfigRegModule(address,Info); 
   input [`ADDRBUS_range] address; 
   input 		  Info; 
   reg [`ConfigurationReg_dim - 1 : 0] CR_reg; 
   reg [`BYTE_range] 		       Status; 
`define ReadMode_bit         15
`define ClockLatency_MSBbit  14
`define ClockLatency_LSBbit  11
`define WaitPolarity_bit     10
`define WaitConfig_bit       8
`define BurstType_bit        7
`define ValidClockEdge_bit   6
`define WrapBurst_bit        3
`define BurstLength_MSBbit   2
`define BurstLength_LSBbit   0
   wire 			       isASynchronous      = CR_reg[`ReadMode_bit] ? `TRUE : `FALSE; 
   wire 			       isSynchronous       = CR_reg[`ReadMode_bit] ? `FALSE : `TRUE; 
   wire [3:0] 			       Xlatency      = (CR_reg[`ClockLatency_MSBbit : `ClockLatency_LSBbit]<2 && 
							CR_reg[`ClockLatency_MSBbit : `ClockLatency_LSBbit]>15) ? 0 :
				       CR_reg[`ClockLatency_MSBbit : `ClockLatency_LSBbit];
   wire 			       isWaitPolActiveHigh = CR_reg[`WaitPolarity_bit] ? `TRUE : `FALSE; 
   wire 			       isWaitBeforeActive    = CR_reg[`WaitConfig_bit] ? `TRUE : `FALSE; 
   wire 			       isRisingClockEdge   = CR_reg[`ValidClockEdge_bit] ? `TRUE : `FALSE; 
   wire 			       isWrapBurst         = CR_reg[`WrapBurst_bit] ? `FALSE : `TRUE; 
   wire 			       isNoWrapBurst       = CR_reg[`WrapBurst_bit] ? `TRUE : `FALSE; 
   wire [4:0] 			       BurstLength   = CR_reg[`BurstLength_MSBbit : `BurstLength_LSBbit] == 1 ? 4 : 
				       CR_reg[`BurstLength_MSBbit : `BurstLength_LSBbit] == 2 ? 8 :
				       CR_reg[`BurstLength_MSBbit : `BurstLength_LSBbit] == 3 ? 16:
				       0; 
   wire [2:0] 			       BurstLength_bit = CR_reg[`BurstLength_MSBbit : `BurstLength_LSBbit] == 1 ? 2 : 
				       CR_reg[`BurstLength_MSBbit : `BurstLength_LSBbit] == 2 ? 3 :
				       CR_reg[`BurstLength_MSBbit : `BurstLength_LSBbit] == 3 ? 4:
				       0; 
initial begin
   Status = `NoError_msg;
   CR_reg = `ConfigReg_default;
end
always @(isSynchronous) begin
   if (Info)
      if (isSynchronous)
         $write("[%t]  Synchronous Read Mode\n",$time);
      else
         $write("[%t]  ASynchronous Read Mode\n",$time);
end
always @(Kernel.ResetEvent) begin
   Status = `NoError_msg;
   CR_reg = `ConfigReg_default;
end
function [`ConfigurationReg_dim - 1 : 0] getConfigReg;
   input required;
   begin
      getConfigReg = CR_reg;
   end
endfunction
task putConfigReg;
   output [`BYTE_range] outStatus;
   reg [`BYTE_range] 	outStatus;
   integer 		count;
   begin
      CR_reg = address[`ConfigurationReg_dim - 1 : 0];
      outStatus = Status;
   end
endtask
endmodule