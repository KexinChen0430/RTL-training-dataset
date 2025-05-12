
module dcm_sp_maximum_period_check(clock,rst);

  parameter  clock_name = "";
  parameter  maximum_period = 0;
  input  clock;
  input  rst;
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
        clock_period = $time+(0-clock_edge);
        if (clock_period > maximum_period) 
          begin
            if (rst == 0) 
              $display(" Warning : Input clock period of %1.3f ns, on the %s port of instance %m exceeds allowed value of %1.3f ns at time %1.3f ns.",
                       clock_period*(1/1000.),clock_name,maximum_period*(1/1000.),
                       (1/1000.)*$time);
              
          end
          
      end
endmodule

