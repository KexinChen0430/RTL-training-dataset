
module ultrasonicTransmitter(input  SYS_CLK,
                             input  CLK_40,
                             input  RST,ON,
                             output reg burstStart,
                             output reg roundTripFlag,
                             output [1:0] pulseOutput);

  reg  [9:0] usonic;

  
  always @(posedge CLK_40)
      usonic <= (ON & ~RST) ? (usonic+1) : 0;
  localparam  burst32 = 32768;

  localparam  wait33ms = 1350000;

  localparam  wait32_5735ms = 1341261;

  reg  [20:0] counter_burst;

  reg  usonicpulse;

  
  always @(posedge CLK_40)
      begin
        counter_burst <= ((counter_burst < (burst32+wait32_5735ms)) & (ON & ~RST)) ? (counter_burst+1) : 0;
        usonicpulse <= usonic[9] & (counter_burst < burst32);
      end
  assign pulseOutput = {(~RST & usonicpulse) & ON,(ON & ~RST) & ~usonicpulse};
  wire START_SIGNAL;

  assign START_SIGNAL = counter_burst == 0;
  reg  startPREV;

  
  always @(posedge SYS_CLK)
      begin
        startPREV <= START_SIGNAL;
        burstStart <= ((~RST & ~START_SIGNAL) & (ON & startPREV)) ? 1 : 0;
      end
  wire ROUNDTRIP;

  assign ROUNDTRIP = counter_burst > 584;
  reg  roundTripPREV;

  
  always @(posedge SYS_CLK)
      begin
        roundTripPREV <= ROUNDTRIP;
        roundTripFlag <= ((ON & ~roundTripPREV) & (ROUNDTRIP & ~RST)) ? 1 : 0;
      end
endmodule

