
module GP_SHREG(input  nRST,
                input  CLK,
                input  IN,
                output OUTA,
                output OUTB);

  parameter  OUTA_TAP = 1;
  parameter  OUTA_INVERT = 0;
  parameter  OUTB_TAP = 1;
  reg  [15:0]  shreg = 0;

  
  always @(posedge CLK or negedge nRST)
      begin
        if (!nRST) shreg = 0;
        else shreg <= {shreg[14:0],IN};
      end
  assign OUTA = OUTA_INVERT ? ~shreg[(-1)+OUTA_TAP] : shreg[(-1)+OUTA_TAP];
  assign OUTB = shreg[(-1)+OUTB_TAP];
endmodule

