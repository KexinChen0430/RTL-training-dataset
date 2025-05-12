module 
    output [31:0] bb_sample, 
    output bb_strobe 
);
    assign ddc_in_i = frontend_i; 
    assign ddc_in_q = frontend_q; 
    assign bb_sample = ddc_out_sample; 
    assign bb_strobe = ddc_out_strobe; 
    assign ddc_out_enable = enable; 
endmodule 