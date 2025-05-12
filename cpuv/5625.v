module elevator(current_floor,leds,switches,clock);
   elevator ev0(cf,lights,sw,tbclock);
    initial
       tbclock = 1'b0;
    always
        #1 tbclock = ~tbclock;
    initial begin
        $monitor("At time",$time," switches:%b,lights:%b,floor:%d",sw,lights,cf);
        #200 $finish;
    end
    initial begin
        #5 sw[2] <= 1;
        #1 sw[2] <= 0;
        #50 sw[1] <= 1;
        #1 sw[1] <= 0;
    end
endmodule