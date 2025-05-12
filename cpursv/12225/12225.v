
module EFUSE_USR(EFUSEUSR);

  parameter [31:0]  SIM_EFUSE_VALUE = 32'h00000000;
  output [31:0] EFUSEUSR;

  assign EFUSEUSR = SIM_EFUSE_VALUE;
  
  specify
    specparam  PATHPULSE$ = 0;

  endspecify

endmodule

