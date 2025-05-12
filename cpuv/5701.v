module elevator(leds,switches,clock); 
elevator e0(floor_num,light_out,switch_in,tb_clock); 
initial begin 
    $monitor("At time",$time," switch is %b and led %b. State %b ",switch_in,light_out); 
     #200 $finish; 
end
initial begin 
    switch_in = 0; 
     #20 switch_in[0] = 1; 
     #20 switch_in[0] = 0; 
     #20 switch_in[1] = 1; 
     #20 switch_in[1] = 0; 
     #20 switch_in[2] = 1; 
end
initial 
    tb_clock = 1'b0; 
always 
    #1 tb_clock = ~tb_clock; 
endmodule 