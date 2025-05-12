module IBUFDS_DIFF_OUT_IBUFDISABLE (O, OB, I, IB, IBUFDISABLE); 
    parameter DIFF_TERM = "FALSE"; 
    parameter DQS_BIAS = "FALSE"; 
    parameter IBUF_LOW_PWR = "TRUE"; 
    parameter IOSTANDARD = "DEFAULT"; 
    parameter SIM_DEVICE = "7SERIES"; 
    parameter USE_IBUFDISABLE = "TRUE"; 
`ifdef XIL_TIMING
    parameter LOC = "UNPLACED"; 
`endif 
    output O; 
    output OB; 
    input I; 
    input IB; 
    input IBUFDISABLE; 
  localparam MODULE_NAME = "IBUFDS_DIFF_OUT_IBUFDISABLE"; 
    reg  o_out; 
    reg DQS_BIAS_BINARY = 1'b0; 
    wire out_val; 
    wire out_b_val; 
    initial begin 
    end
    always @(I or IB or DQS_BIAS_BINARY) begin 
    end
   generate
   endgenerate
    generate
    endgenerate
`ifdef XIL_TIMING
    specify
    endspecify
`endif 
endmodule 