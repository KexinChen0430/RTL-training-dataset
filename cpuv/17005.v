module at the_start; 
    reg clock; 
    reg reset_low; 
    reg ip_valid; 
    reg serial_ip; 
    wire d_out; 
    wire valid_op; 
    always begin 
        #5 clock = 0; 
        #5 clock = 1; 
    end 
    SIPO sipo_c (
        .d_out(d_out), 
        .valid_op(valid_op), 
        .serial_ip(serial_ip), 
        .ip_valid(ip_valid), 
        .reset_low(reset_low), 
        .clock(clock) 
    );
    initial begin 
        $display($time, " << Starting the simulation >>"); 
        reset_low=1'd0; 
        ip_valid=1'd1; 
        serial_ip=1'd1; 
        #30 
        $display($time, " << Finishing the simulation >>"); 
        $finish; 
    end 
endmodule 