module RegisterFile #(
  parameter LOG2_NUM_REGISTERS = 5,
  parameter NUM_REGISTERS = 1 << (LOG2_NUM_REGISTERS)
)(
  input clk,
  input reset,
  input [LOG2_NUM_REGISTERS-1:0] waddr,
  input [`CPU_DATA_BITS-1:0] wdata,
  input write_enable,
  input [LOG2_NUM_REGISTERS-1:0] raddr0,
  output [`CPU_DATA_BITS-1:0] rdata0,
  input [LOG2_NUM_REGISTERS-1:0] raddr1,
  output [`CPU_DATA_BITS-1:0] rdata1
);
 reg [`CPU_DATA_BITS-1:0] registers[NUM_REGISTERS-1:0];
 assign rdata0 = registers[raddr0];
 assign rdata1 = registers[raddr1];
 always @(posedge clk) begin
   if (write_enable && waddr != 0) registers[waddr] <= wdata;
 end
endmodule