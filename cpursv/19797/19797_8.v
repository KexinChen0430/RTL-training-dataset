
module ClockDivider  #(parameter  Bits_counter = 32)
  (input  P_CLOCK,
   output P_TIMER_OUT,
   input  [(-1)+Bits_counter:0] P_COMPARATOR);

  reg  [(-1)+Bits_counter:0] r_Timer;
  reg  r_Result;

  
  always @(posedge P_CLOCK)
      begin
        if (r_Timer >= P_COMPARATOR) 
          begin
            r_Result <= !r_Result;
            r_Timer <= 0;
          end
        else 
          begin
            r_Timer <= 1+r_Timer;
            r_Result <= r_Result;
          end
      end
  assign P_TIMER_OUT = r_Result;
endmodule

