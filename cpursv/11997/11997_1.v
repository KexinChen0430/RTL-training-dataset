
module handler_params_encoder(input  [7:0] irqNumber,
                              input  irqDetected,
                              output [17:1] EIC_Offset,
                              output [3:0] EIC_ShadowSet,
                              output [7:0] EIC_Interrupt,
                              output [5:0] EIC_Vector);

  assign EIC_ShadowSet = 4'b0;
  assign EIC_Interrupt = irqDetected ? (1+irqNumber) : 8'b0;
  assign EIC_Offset = 17'h0;
  assign EIC_Vector = irqNumber[5:0];
endmodule

