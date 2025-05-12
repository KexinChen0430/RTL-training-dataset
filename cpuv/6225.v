module interstage_buffer_mem_wb(clock);
    register#(4) wb_control_signals_buffer( 
        mem_control_signals, 
        clock,               
        wb_control_signals   
    );
endmodule