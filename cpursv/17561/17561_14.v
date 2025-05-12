
module IBUFDS_IBUFDISABLE_INT(O,I,IB,IBUFDISABLE);

  parameter  DIFF_TERM = FALSE;
  parameter  DQS_BIAS = FALSE;
  parameter  IBUF_LOW_PWR = TRUE;
  parameter  IOSTANDARD = DEFAULT;
  parameter  USE_IBUFDISABLE = TRUE;
  localparam  MODULE_NAME = IBUFDS_IBUFDISABLE_INT;
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

      TRUE: DQS_BIAS_BINARY <= #1 1'b1;

      FALSE: DQS_BIAS_BINARY <= #1 1'b0;

      default: begin
            $display("Attribute Syntax Error : The attribute DQS_BIAS on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.",
                     MODULE_NAME,DQS_BIAS);
            $finish;
          end

    endcase

    case (DIFF_TERM)

      TRUE,FALSE:  ;

      default: begin
            $display("Attribute Syntax Error : The attribute DIFF_TERM on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.",
                     MODULE_NAME,DIFF_TERM);
            $finish;
          end

    endcase

    case (IBUF_LOW_PWR)

      FALSE,TRUE:  ;

      default: begin
            $display("Attribute Syntax Error : The attribute IBUF_LOW_PWR on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.",
                     MODULE_NAME,IBUF_LOW_PWR);
            $finish;
          end

    endcase

    case (USE_IBUFDISABLE)

      TRUE: USE_IBUFDISABLE_BINARY <= #1 1'b1;

      FALSE: USE_IBUFDISABLE_BINARY <= #1 1'b0;

      default: begin
            $display("Attribute Syntax Error : The attribute USE_IBUFDISABLE on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.",
                     MODULE_NAME,USE_IBUFDISABLE);
            $finish;
          end

    endcase

  end
  
  always @(i_in or ib_in or DQS_BIAS_BINARY)
      begin
        if ((i_in == 1'b1) && (ib_in == 1'b0)) o_out <= 1'b1;
        else if ((ib_in == 1'b1) && (i_in == 1'b0)) o_out <= 1'b0;
        else if (
(
(((i_in === 1'bz) || (i_in == 1'b0)) && (ib_in == 1'b1)) || 
((ib_in === 1'bz) || 
((ib_in == 1'b1) && (i_in === 1'bz)))) && 
                 (((i_in === 1'bz) || (i_in == 1'b0)) && 
((i_in === 1'bz) || (ib_in === 1'bz) || (ib_in == 1'b1)))) 
          if (DQS_BIAS_BINARY == 1'b1) o_out <= 1'b0;
          else o_out <= 1'bx;
        else if ((ib_in === 1'bx) || (i_in === 1'bx)) o_out <= 1'bx;
          
      end
endmodule

