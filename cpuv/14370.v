module IBUFDS_INTERMDISABLE (O, I, IB, IBUFDISABLE, INTERMDISABLE); 
`ifdef XIL_TIMING 
  parameter LOC = "UNPLACED"; 
`endif 
  parameter DIFF_TERM = "FALSE"; 
  parameter DQS_BIAS = "FALSE"; 
  parameter IBUF_LOW_PWR = "TRUE"; 
  parameter IOSTANDARD = "DEFAULT"; 
  parameter SIM_DEVICE = "7SERIES"; 
  parameter USE_IBUFDISABLE = "TRUE"; 
  localparam MODULE_NAME = "IBUFDS_INTERMDISABLE"; 
    output O; 
    input  I; 
    input  IB; 
    input  IBUFDISABLE; 
    input  INTERMDISABLE; 
    wire i_in, ib_in, ibufdisable_in, intermdisable_in; 
    reg o_out; 
    wire out_val; 
    reg DQS_BIAS_BINARY = 1'b0; 
    reg USE_IBUFDISABLE_BINARY = 1'b0; 
    assign O =  (USE_IBUFDISABLE_BINARY == 1'b0) ? o_out : 
                ((ibufdisable_in === 1'b1) ? out_val : ((ibufdisable_in === 1'b0) ? o_out : 1'bx));
    assign i_in = I; 
    assign ib_in = IB; 
    assign ibufdisable_in = IBUFDISABLE; 
    assign intermdisable_in = INTERMDISABLE; 
    initial begin 
        case (DQS_BIAS) 
            "TRUE"  : DQS_BIAS_BINARY <= #1 1'b1; 
            "FALSE" : DQS_BIAS_BINARY <= #1 1'b0; 
            default : begin
                          $display("Attribute Syntax Error : The attribute DQS_BIAS on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, DQS_BIAS); 
                          #1 $finish; 
                      end
        endcase 
        if ((SIM_DEVICE != "7SERIES") &&
    end
   generate 
       case (SIM_DEVICE) 
         "7SERIES" : begin
                        assign out_val = 1'b1; 
                     end
         default : begin
                        assign out_val = 1'b0; 
                     end
        endcase
   endgenerate 
    always @(i_in or ib_in or DQS_BIAS_BINARY) begin 
    end
`ifdef XIL_TIMING 
    specify 
        (I => O)                = (0:0:0,  0:0:0); 
        (IB => O)               = (0:0:0,  0:0:0); 
        (IBUFDISABLE => O)      = (0:0:0,  0:0:0); 
        (INTERMDISABLE => O)    = (0:0:0,  0:0:0); 
        specparam PATHPULSE$ = 0; 
    endspecify 
`endif 
endmodule 