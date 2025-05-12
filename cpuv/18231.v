module ; 
   parameter TIMEOUT = 200 ; 
   reg activity_toggle ; 
   reg timer_toggle ; 
   reg [63:0] time_stamp ; 
   initial 
     begin
        activity_toggle <= 0 ; 
        timer_toggle <= 0 ; 
        time_stamp <= $time ; 
        reg unused_result ; 
        unused_result = ebfm_display(EBFM_MSG_ERROR_FATAL, "Simulation started. If no activity on activity_toggle within 200 us, simulation will stop with error: Simulation stopped due to inactivity!"); 
        unused_result = ebfm_log_start_sim("Watchdog timer test started. If no activity on activity_toggle within 200 us, simulation will stop with error: Simulation stopped due to inactivity!"); 
        unused_result = ebfm_log_stop_sim(1); 
        forever #100000; 
     end
   always 
     begin
        #(TIMEOUT) 
          timer_toggle <= ! timer_toggle ; 
     end
   always @(activity_toggle or timer_toggle) 
     begin : watchdog
        reg unused_result ; 
        if ( ($time - time_stamp) >= TIMEOUT) 
          begin
             unused_result = ebfm_display(EBFM_MSG_ERROR_FATAL, "Simulation stopped due to inactivity!"); 
          end
        time_stamp <= $time ; 
     end
endmodule 