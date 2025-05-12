
module pwm_dac(input  wire clk_i,
               input  wire [15:0] din,
               output reg dout);

  reg  [16:0] PWM_accumulator;

  
  always @(posedge clk_i)
      begin
        PWM_accumulator[16:0] = PWM_accumulator[15:0]+{~din[15],din[14:0]};
        dout = PWM_accumulator[16];
      end
endmodule

