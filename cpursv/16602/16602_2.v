
module IOBUFDS_DCIEN(O,IO,IOB,DCITERMDISABLE,I,IBUFDISABLE,T);

  parameter  DIFF_TERM = FALSE;
  parameter  DQS_BIAS = FALSE;
  parameter  IBUF_LOW_PWR = TRUE;
  parameter  IOSTANDARD = DEFAULT;
  parameter  SIM_DEVICE = 7SERIES;
  parameter  SLEW = SLOW;
  parameter  USE_IBUFDISABLE = TRUE;
  localparam  MODULE_NAME = IOBUFDS_DCIEN;
  output O;
  inout  IO;
  inout  IOB;
  input  DCITERMDISABLE;
  input  I;
  input  IBUFDISABLE;
  input  T;
  wire 
      i_in             ,
      io_in            ,
      iob_in           ,
      ibufdisable_in   ,
      dcitermdisable_in,
      t_in             ,
      out_val          ;
  reg  o_out,io_out,iob_out;
  reg  O_int;
  reg   DQS_BIAS_BINARY = 1'b0;
  reg   USE_IBUFDISABLE_BINARY = 1'b0;
  wire t_or_gts;
  wire not_t_or_ibufdisable;
  tri0  GTS = glbl.GTS;

  assign O = (USE_IBUFDISABLE_BINARY == 1'b0) ? o_out : 
             (not_t_or_ibufdisable === 1'b1) ? out_val : 
             (not_t_or_ibufdisable === 1'b0) ? o_out : 1'bx;
  assign dcitermdisable_in = DCITERMDISABLE;
  assign i_in = I;
  assign ibufdisable_in = IBUFDISABLE;
  assign t_in = T;
  assign io_in = IO;
  assign iob_in = IOB;
  assign t_or_gts = t_in || GTS;
  assign IO = t_or_gts ? 1'bz : i_in;
  assign IOB = t_or_gts ? 1'bz : ~i_in;
  assign not_t_or_ibufdisable = ~t_in || ibufdisable_in;
  
  initial  
  begin

  end
  
  generate
      case (SIM_DEVICE)

        7SERIES: begin
              assign out_val = 1'b1;
            end

        ULTRASCALE: begin
              assign out_val = 1'b0;
            end

      endcase

  endgenerate

  
  always @(io_in or iob_in or DQS_BIAS_BINARY)  begin

  end
endmodule

