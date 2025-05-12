
module IOBUFDS(O,IO,IOB,I,T);

  parameter  DIFF_TERM = FALSE;
  parameter  DQS_BIAS = FALSE;
  parameter  IBUF_LOW_PWR = TRUE;
  parameter  IOSTANDARD = DEFAULT;
  parameter  SLEW = SLOW;
  localparam  MODULE_NAME = IOBUFDS;
  output O;
  inout  IO,IOB;
  input  I,T;
  wire i_in,io_in,iob_in,t_in;
  reg  o_out,io_out,iob_out;
  reg  O_int;
  reg   DQS_BIAS_BINARY = 1'b0;
  wire t_or_gts;
  tri0  GTS = glbl.GTS;

  assign i_in = I;
  assign t_in = T;
  assign io_in = IO;
  assign iob_in = IOB;
  assign t_or_gts = GTS || t_in;
  assign IO = t_or_gts ? 1'bz : i_in;
  assign IOB = t_or_gts ? 1'bz : ~i_in;
  
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

    if ((IOSTANDARD == LVDS_25) || (IOSTANDARD == LVDSEXT_25)) 
      begin
        $display("DRC Warning : The IOSTANDARD attribute on %s instance %m is set to %s.  LVDS_25 is a fixed impedance structure optimized to 100ohm differential. If the intended usage is a bus architecture, please use BLVDS. This is only intended to be used in point to point transmissions that do not have turn around timing requirements",
                 MODULE_NAME,IOSTANDARD);
      end
      
  end
  
  always @(io_in or iob_in or DQS_BIAS_BINARY)  begin

  end
  assign O = o_out;
endmodule

