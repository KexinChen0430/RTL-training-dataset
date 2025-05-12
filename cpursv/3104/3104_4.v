
module Prescaler(input  io_clear,
                 input  [15:0] io_limit,
                 output io_overflow,
                 input  io_mainClk,
                 input  resetCtrl_systemReset);

  wire _zz_1;
  reg  [15:0] counter;

  assign io_overflow = _zz_1;
  assign _zz_1 = counter == io_limit;
  
  always @(posedge io_mainClk)
      begin
        counter <= 16'b0000000000000001+counter;
        if (_zz_1 || io_clear) 
          begin
            counter <= 16'b0000000000000000;
          end
          
      end
endmodule

