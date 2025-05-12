
module IBUFDS(O,I,IB);

  parameter  CAPACITANCE = DONT_CARE;
  parameter  DIFF_TERM = FALSE;
  parameter  DQS_BIAS = FALSE;
  parameter  IBUF_DELAY_VALUE = 0;
  parameter  IBUF_LOW_PWR = TRUE;
  parameter  IFD_DELAY_VALUE = AUTO;
  parameter  IOSTANDARD = DEFAULT;
  localparam  MODULE_NAME = IBUFDS;
  output O;
  input  I,IB;
  wire i_in,ib_in;
  reg  o_out;
  reg   DQS_BIAS_BINARY = 1'b0;

  assign O = o_out;
  assign i_in = I;
  assign ib_in = IB;
  
  initial  
  begin
    case (DQS_BIAS)

      TRUE: DQS_BIAS_BINARY <= #1 1'b1;

      FALSE: DQS_BIAS_BINARY <= #1 1'b0;

      default: begin
            $display("Attribute Syntax Error : The attribute DQS_BIAS on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.",
                     MODULE_NAME,DQS_BIAS);
            $finish;
          end

    endcase

  end
  
  always @(i_in or ib_in or DQS_BIAS_BINARY)  begin

  end
endmodule

