module output 
assign  ERROR_COUNT_OUT =   error_count_r[7:0]; 
always @(posedge USER_CLK) 
    if(system_reset_r ||  (read_counter_i == (WORDS_IN_BRAM-1))) 
    begin
        read_counter_i   <=  `DLY    10'd0; 
    end
    else if (start_of_packet_detected_r && !track_data_r) 
    begin
        read_counter_i   <=  `DLY    10'd0; 
    end
    else 
    begin
        read_counter_i  <=  `DLY    read_counter_i + 10'd1; 
    end
generate 
if(RX_DATA_WIDTH==80) 
begin : datapath_80
    assign bram_data_r      = rx_data_ram_r[(RX_DATA_WIDTH-1):0]; 
end
else 
begin : datapath_16_20_32_40_64
    assign bram_data_r      = rx_data_ram_r[(16+RX_DATA_WIDTH-1):16]; 
end
endgenerate
always @(posedge USER_CLK)
           rx_data_ram_r <= `DLY  rom[read_counter_i];
endmodule 