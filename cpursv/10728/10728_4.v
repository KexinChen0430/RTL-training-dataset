
module IBUFDS_IBUFDISABLE(O,I,IB,IBUFDISABLE);

  parameter  DIFF_TERM = FALSE;
  parameter  DQS_BIAS = FALSE;
  parameter  IBUF_LOW_PWR = TRUE;
  parameter  IOSTANDARD = DEFAULT;
  parameter  SIM_DEVICE = 7SERIES;
  parameter  USE_IBUFDISABLE = TRUE;
  localparam  MODULE_NAME = IBUFDS_IBUFDISABLE;
  output O;
  input  I;
  input  IB;
  input  IBUFDISABLE;
  wire i_in,ib_in,ibufdisable_in;
  reg  o_out;
  wire out_val;
  reg   DQS_BIAS_BINARY = 1'b0;
  reg   USE_IBUFDISABLE_BINARY = 1'b0;

  assign O = (USE_IBUFDISABLE_BINARY == 1'b0) ? o_out : 
             (ibufdisable_in === 1'b1) ? out_val : 
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
            #1 $finish;
          end

    endcase

    case (DIFF_TERM)

      TRUE,FALSE:  ;

      default: begin
            $display("Attribute Syntax Error : The attribute DIFF_TERM on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.",
                     MODULE_NAME,DIFF_TERM);
            #1 $finish;
          end

    endcase

    case (IBUF_LOW_PWR)

      FALSE,TRUE:  ;

      default: begin
            $display("Attribute Syntax Error : The attribute IBUF_LOW_PWR on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.",
                     MODULE_NAME,IBUF_LOW_PWR);
            #1 $finish;
          end

    endcase

    case (USE_IBUFDISABLE)

      TRUE: USE_IBUFDISABLE_BINARY <= #1 1'b1;

      FALSE: USE_IBUFDISABLE_BINARY <= #1 1'b0;

      default: begin
            $display("Attribute Syntax Error : The attribute USE_IBUFDISABLE on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.",
                     MODULE_NAME,USE_IBUFDISABLE);
            #1 $finish;
          end

    endcase

    if ((SIM_DEVICE != ULTRASCALE) && 
        ((SIM_DEVICE != VERSAL_PRIME_ES2) && 
(SIM_DEVICE != 7SERIES))) 
      begin
        $display("Error: [Unisim %s-106] SIM_DEVICE attribute is set to %s.  Legal values for this attribute are 7SERIES, ULTRASCALE, VERSAL_AI_CORE, VERSAL_AI_CORE_ES1, VERSAL_AI_CORE_ES2, VERSAL_AI_EDGE, VERSAL_AI_EDGE_ES1, VERSAL_AI_EDGE_ES2, VERSAL_AI_RF, VERSAL_AI_RF_ES1, VERSAL_AI_RF_ES2, VERSAL_HBM, VERSAL_HBM_ES1, VERSAL_HBM_ES2, VERSAL_PREMIUM, VERSAL_PREMIUM_ES1, VERSAL_PREMIUM_ES2, VERSAL_PRIME, VERSAL_PRIME_ES1 or VERSAL_PRIME_ES2. Instance: %m",
                 MODULE_NAME,SIM_DEVICE);
        #1 $finish;
      end
      
  end
  
  generate
      case (SIM_DEVICE)

        7SERIES: begin
              assign out_val = 1'b1;
            end

        default: begin
              assign out_val = 1'b0;
            end

      endcase

  endgenerate

  
  always @(i_in or ib_in or DQS_BIAS_BINARY)
      begin
        if ((i_in == 1'b1) && (ib_in == 1'b0)) o_out <= 1'b1;
        else if ((ib_in == 1'b1) && (i_in == 1'b0)) o_out <= 1'b0;
        else if (((ib_in == 1'b1) && (i_in == 1'b0)) || 
                 (
(
((i_in === 1'bz) || (ib_in === 1'bz) || 
((i_in === 1'bz) || (i_in == 1'b0))) && (ib_in == 1'b1) && (i_in === 1'bz)) || 
((ib_in === 1'bz) && 
(
((i_in === 1'bz) || (ib_in === 1'bz) || 
((i_in === 1'bz) || (i_in == 1'b0))) && (ib_in == 1'b1)) && 
((i_in === 1'bz) || 
(((ib_in == 1'b1) && (i_in == 1'b0)) || 
((ib_in === 1'bz) && (i_in === 1'bz)))))) || 
                 (
(((ib_in == 1'b1) && (i_in == 1'b0)) || 
(ib_in === 1'bz)) && 
(
((i_in === 1'bz) || (ib_in === 1'bz) || 
((i_in === 1'bz) || (i_in == 1'b0))) && 
((ib_in === 1'bz) || 
((ib_in == 1'b1) || (i_in === 1'bz)))) && ((i_in === 1'bz) || (i_in == 1'b0)))) 
          if (DQS_BIAS_BINARY == 1'b1) o_out <= 1'b0;
          else o_out <= 1'bx;
        else if ((ib_in === 1'bx) || (i_in === 1'bx)) o_out <= 1'bx;
          
      end
endmodule

