module registers(
  input rst,
  input clk,
  input write_enable,
  input [REG_WIDTH-1 : 0] rs1_offset,
  input [REG_WIDTH-1 : 0] rs2_offset,
  input [REG_WIDTH-1 : 0] rd_offset,
  input [WIDTH-1 : 0] rd_data_in,
  output [WIDTH-1 : 0] rs1_data_out,
  output [WIDTH-1 : 0] rs2_data_out);
  parameter REG_WIDTH = 5;
  parameter WIDTH = 32;
  parameter STACK_REG = 2;
  parameter STACK_START = 1024; 
  localparam REG_COUNT = 1 << REG_WIDTH;
  reg [WIDTH-1 : 0] regs [0 : REG_COUNT-1];
`ifdef IVERILOG
  integer i;
  initial begin
    for (i = 0; i < REG_COUNT; i = i + 1) begin
      regs[i] = 0;
    end
  end
`endif
  assign rs1_data_out = regs[rs1_offset];
  assign rs2_data_out = regs[rs2_offset];
  always @(posedge clk) begin
    if (rst) begin
      regs[2] <= STACK_START;
    end else begin
      if (write_enable && (rd_offset != 0)) begin
        regs[rd_offset] <= rd_data_in;
      end
    end
  end
endmodule