module to test
    lf_edge_detect detect(
        clk, 
        adc_d, 
        8'd127, 
        max, 
        min, 
        high_threshold, 
        highz_threshold, 
        lowz_threshold, 
        low_threshold, 
        edge_state, 
        edge_toggle 
    );
endmodule