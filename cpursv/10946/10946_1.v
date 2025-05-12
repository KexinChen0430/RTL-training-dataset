
module wdregister(input  clk,
                  input  ctrlld,
                  input  wdtripce,
                  input  wdogdis,
                  input  [7:0] wrtdata,
                  output motorenaint,
                  output run0,
                  output run1,
                  output run2,
                  output [7:0] controlrdata);

  reg   motorenaintreg = 0;
  reg   wdtrip = 0;
  reg  [7:0]  controlreg = 0;
  reg  [7:0] controlrdatareg;

  assign motorenaint = motorenaintreg;
  assign run0 = controlreg[0];
  assign run1 = controlreg[1];
  assign run2 = controlreg[2];
  assign controlrdata = controlrdatareg;
  
  always @(*)
      begin
        controlrdatareg <= {wdtrip,wdogdis,1'b0,1'b0,controlreg[3:0]};
        motorenaintreg <= controlreg[3] & ~wdtrip;
      end
  
  always @(posedge clk)
      begin
        if (ctrlld) controlreg <= wrtdata;
          
        if (wdtripce) wdtrip <= 1;
          
        if ((wrtdata == 8'h80) && ctrlld) wdtrip <= 0;
          
      end
endmodule

