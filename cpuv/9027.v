module dcm_adv_maximum_period_check (clock,  rst);
parameter clock_name = "";
parameter maximum_period = 0;
input clock;
input rst;
time clock_edge;
time clock_period;
initial begin
    clock_edge = 0; 
    clock_period = 0; 
end
always @(posedge clock )
begin
    clock_edge <= $time; 
    clock_period <= $time - clock_edge; 
    if (clock_period > maximum_period && rst == 0 ) begin
        $display(" Warning : Input clock period of, %1.3f ns, on the %s port of instance %m exceeds allowed value of %1.3f ns at simulation time %1.3f ns.", clock_period/1000.0, clock_name, maximum_period/1000.0, $time/1000.0);
    end
end
endmodule