
module PHASE_ALIGN(ENA_COMMA_ALIGN,RX_REC_CLK,ENA_CALIGN_REC);

  input  ENA_COMMA_ALIGN;
  input  RX_REC_CLK;
  output ENA_CALIGN_REC;
  reg  [0:1] phase_align_flops_r;

  
  always @(posedge RX_REC_CLK)
      begin
        phase_align_flops_r[0] <= #1 ENA_COMMA_ALIGN;
        phase_align_flops_r[1] <= #1 phase_align_flops_r[0];
      end
  assign ENA_CALIGN_REC = phase_align_flops_r[1];
endmodule

