
module wdtimer(input  clk,
               input  cein,
               input  enable,
               input  wdreset,
               input  wdogdis,
               input  [7:0] wdogdivreg,
               output wdtripce);

  reg  [7:0]  counter = 0;
  reg   wdtripcesreg = 0;
  reg   wdtripcereg = 0;
  reg   wdogdisreg = 0;

  assign wdtripce = wdtripcesreg;
  
  always @(*)
      begin
        if (~wdreset && (wdogdivreg == counter) && 
            (~wdogdisreg && enable)) wdtripcereg <= cein;
        else wdtripcereg <= 0;
      end
  
  always @(posedge clk)
      begin
        wdtripcesreg <= wdtripcereg;
        wdogdisreg = wdogdis;
        if ((~wdogdisreg & ~wdreset) & enable) 
          begin
            if (cein) counter <= counter+1;
              
          end
        else counter <= 8'h00;
      end
endmodule

