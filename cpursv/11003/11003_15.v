
module dcm_maximum_period_check(clock);

  parameter  clock_name = "";
  parameter  maximum_period = 0;
  input  clock;
  time  clock_edge;
  time  clock_period;

  
  initial  
  begin
    clock_edge = 0;
    clock_period = 0;
  end
  
  always @(posedge clock)
      begin
        clock_edge <= $time;
        clock_period <= (0-clock_edge)+$time;
        if (clock_period > maximum_period) 
          begin
            $display(" Warning : Input clock period of, %1.3f ns, on the %s port of instance %m exceeds allotted value of %1.3f ns at simulation time %1.3f ns.",
                     clock_period*(1/1000.),clock_name,maximum_period*(1/1000.),$time/1000.);
          end
          
      end
endmodule

