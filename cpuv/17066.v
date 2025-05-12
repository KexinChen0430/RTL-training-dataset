module will reset all the lanes if this occurs while they are all in
    always @(posedge USER_CLK) 
        if(RX_SP|!ready_r)  
            counter4_r  <=  `DLY    {ready_r,counter4_r[0:14]}; 
    assign remote_reset_watchdog_done_r = counter4_r[15]; 
    always @(posedge USER_CLK) 
        if(do_watchdog_count_r|!ack_r)  
            counter5_r  <=  `DLY    {ack_r,counter5_r[0:14]}; 
    always @(posedge USER_CLK) 
        prev_count_128d_done_r  <=  `DLY    count_128d_done_r; 
    always @(posedge USER_CLK) 
        do_watchdog_count_r <=  `DLY    count_128d_done_r & !prev_count_128d_done_r; 
    assign watchdog_done_r = counter5_r[15]; 
    assign  sp_polarity_c   =   !RX_NEG; 
    initial
        rx_polarity_r <=  1'b0; 
    always @(posedge USER_CLK) 
        if(polarity_r & !sp_polarity_c)  
            rx_polarity_r <=  `DLY    ~rx_polarity_r; 
    assign  RX_POLARITY =   rx_polarity_r; 
endmodule 