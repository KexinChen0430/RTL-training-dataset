module stays in the do_cc state for 6 cycles.  It starts
     always @(posedge USER_CLK)
        if(!CHANNEL_UP)                 DO_CC <=  `DLY    1'b0;
        else if(start_cc_c)             DO_CC <=  `DLY    1'b1;
        else if(|cc_count_r)            DO_CC <=  `DLY    1'b1;
        else                            DO_CC <=  `DLY    1'b0;
 endmodule