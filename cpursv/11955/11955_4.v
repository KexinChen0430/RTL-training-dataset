
module Prescaler(input  io_clear,
                 input  [15:0] io_limit,
                 output io_overflow,
                 input  io_mainClk,
                 input  resetCtrl_systemReset);

  reg  [15:0] counter;

  assign io_overflow = counter == io_limit;
  
  always @(posedge io_mainClk)
      begin
        counter <= 16'b0000000000000001+counter;
        if (io_overflow || io_clear) 
          begin
            counter <= 16'b0000000000000000;
          end
          
      end
endmodule

