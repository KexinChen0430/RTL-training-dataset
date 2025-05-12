module sends an SCP character
    always @(posedge USER_CLK) 
        if(!CHANNEL_UP) 
        begin
            rst_r       <=  `DLY    1'b1; 
            start_r     <=  `DLY    1'b0; 
            run_r       <=  `DLY    1'b0; 
        end
        else if(!DO_CC) 
        begin
            rst_r       <=  `DLY    1'b0; 
            start_r     <=  `DLY    next_start_c; 
            run_r       <=  `DLY    next_run_c; 
        end
    assign  next_start_c    =   rst_r; 
    assign  next_run_c      =   start_r || 
                                run_r; 
endmodule