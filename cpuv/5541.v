module definition 
    assign burst_pending_burstcount      = burst_counter; 
    assign burst_next_pending_burstcount = burst_counter_next; 
    assign burst_accepted = burst_ready & burst_valid; 
    always @ (*) 
    begin
        if (burst_accepted & burst_consumed_valid) 
        begin
            burst_counter_next = burst_counter + 1 - burst_counsumed_burstcount; 
        end
        else if (burst_accepted) 
        begin
            burst_counter_next = burst_counter + 1; 
        end
        else if (burst_consumed_valid) 
        begin
            burst_counter_next = burst_counter - burst_counsumed_burstcount; 
        end
        else 
        begin
            burst_counter_next = burst_counter; 
        end
    end
    always @ (posedge ctl_clk or negedge ctl_reset_n) 
    begin
        if (~ctl_reset_n) 
        begin
            burst_counter <= 0; 
        end
        else 
        begin
            burst_counter <= burst_counter_next; 
        end
    end
endmodule 