
module IBUFDS_IBUFDISABLE_INT(O,I,IB,IBUFDISABLE);

  parameter  DIFF_TERM = "FALSE";
  parameter  DQS_BIAS = "FALSE";
  parameter  IBUF_LOW_PWR = "TRUE";
  parameter  IOSTANDARD = "DEFAULT";
  parameter  USE_IBUFDISABLE = "TRUE";
  localparam  MODULE_NAME = "IBUFDS_IBUFDISABLE_INT";
  output O;
  input  I;
  input  IB;
  input  IBUFDISABLE;
  wire i_in,ib_in,ibufdisable_in;
  reg  o_out;
  reg   DQS_BIAS_BINARY = 1'b0;
  reg   USE_IBUFDISABLE_BINARY = 1'b0;

  assign O = (USE_IBUFDISABLE_BINARY == 1'b0) ? o_out : 
             (ibufdisable_in === 1'b1) ? 1'b1 : 
             (ibufdisable_in === 1'b0) ? o_out : 1'bx;
  assign i_in = I;
  assign ib_in = IB;
  assign ibufdisable_in = IBUFDISABLE;
  
  initial  
  begin
    case (DQS_BIAS)

      "TRUE": DQS_BIAS_BINARY <= #1 1'b1;

      "FALSE": DQS_BIAS_BINARY <= #1 1'b0;

      default: begin
            $display("Attribute Syntax Error : The attribute DQS_BIAS on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.",
                     MODULE_NAME,DQS_BIAS);
            #1 $finish;
          end

    endcase

  end
  
  always @(i_in or ib_in or DQS_BIAS_BINARY)  begin

  end
endmodule

