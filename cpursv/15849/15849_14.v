
module IBUFDS_DIFF_OUT_INTERMDISABLE(O,OB,I,IB,IBUFDISABLE,INTERMDISABLE);

  parameter  DIFF_TERM = FALSE;
  parameter  DQS_BIAS = FALSE;
  parameter  IBUF_LOW_PWR = TRUE;
  parameter  IOSTANDARD = DEFAULT;
  parameter  SIM_DEVICE = 7SERIES;
  parameter  USE_IBUFDISABLE = TRUE;
  output O;
  output OB;
  input  I;
  input  IB;
  input  IBUFDISABLE;
  input  INTERMDISABLE;
  reg  o_out;
  reg   DQS_BIAS_BINARY = 1'b0;
  wire out_val;
  wire out_b_val;

  
  initial  
  begin
    case (DQS_BIAS)

      TRUE: DQS_BIAS_BINARY <= #1 1'b1;

      FALSE: DQS_BIAS_BINARY <= #1 1'b0;

      default: begin
            $display("Attribute Syntax Error : The attribute DQS_BIAS on IBUFDS_DIFF_OUT_INTERMDISABLE instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.",
                     DQS_BIAS);
            $finish;
          end

    endcase

    if ((SIM_DEVICE != 7SERIES) && (SIM_DEVICE != ULTRASCALE)) 
      begin
        $display("Attribute Syntax Error : The attribute SIM_DEVICE on IBUFDS_DIFF_OUT_INTERMDISABLE instance %m is set to %s.  Legal values for this attribute are 7SERIES or ULTRASCALE.",
                 SIM_DEVICE);
        $finish;
      end
      
    case (DIFF_TERM)

      TRUE,FALSE:  ;

      default: begin
            $display("Attribute Syntax Error : The attribute DIFF_TERM on IBUFDS_DIFF_OUT_INTERMDISABLE instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.",
                     DIFF_TERM);
            $finish;
          end

    endcase

    case (IBUF_LOW_PWR)

      FALSE,TRUE:  ;

      default: begin
            $display("Attribute Syntax Error : The attribute IBUF_LOW_PWR on IBUFDS_DIFF_OUT_INTERMDISABLE instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.",
                     IBUF_LOW_PWR);
            $finish;
          end

    endcase

  end
  
  always @(I or IB or DQS_BIAS_BINARY)
      begin
        if ((IB == 1'b0) && (I == 1'b1)) o_out <= I;
        else if ((I == 1'b0) && (IB == 1'b1)) o_out <= I;
        else if (
(
(((IB == 1'b1) || (I === 1'bz)) && 
((IB == 1'b1) || (IB === 1'bz))) || ((IB === 1'bz) && (I == 1'b0))) && 
                 (((IB == 1'b1) || (IB === 1'bz) || (I === 1'bz)) && 
(((I == 1'b0) || ((I === 1'bz) || (IB === 1'bz))) && 
((I == 1'b0) || (IB === 1'bz) || (IB == 1'b1))) && ((IB == 1'b1) || (IB === 1'bz))) && 
                 (((I === 1'bz) || (I == 1'b0)) && 
((IB == 1'b1) || (IB === 1'bz) || (I === 1'bz)))) 
          if (DQS_BIAS_BINARY == 1'b1) o_out <= 1'b0;
          else o_out <= 1'bx;
        else if ((IB == 1'bx) || (I == 1'bx)) o_out <= 1'bx;
          
      end
  
  generate
      case (SIM_DEVICE)

        7SERIES: begin
              assign out_val = 1'b1;
              assign out_b_val = 1'b1;
            end

        ULTRASCALE: begin
              assign out_val = 1'b0;
              assign out_b_val = 1'bx;
            end

      endcase

  endgenerate

  
  generate
      case (USE_IBUFDISABLE)

        TRUE: begin
              assign O = (IBUFDISABLE == 0) ? o_out : 
             (IBUFDISABLE == 1) ? out_val : 1'bx;
              assign OB = (IBUFDISABLE == 0) ? ~o_out : 
              (IBUFDISABLE == 1) ? out_b_val : 1'bx;
            end

        FALSE: begin
              assign O = o_out;
              assign OB = ~o_out;
            end

      endcase

  endgenerate

endmodule

