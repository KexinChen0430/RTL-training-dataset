module ready_load_whole_slice_into_header_register 
    data_shift_register [95:64] <= rx_data [63:32]; 
end
else begin
    header2                     <= header2;         
    data_shift_register [95:64] <= data_shift_register[95:64] 
end
end
DATA3:  begin                                           
    if (rx_ready) begin
        data_shift_register [31:0]  <= data_shift_register [95:64]; 
        data_shift_register [95:32] <= rx_data;                     
    end
    else begin
        data_shift_register [31:0]  <= data_shift_register [31:0];   
        data_shift_register [95:32] <= data_shift_register [95:32];  
    end
end
DATA4:  begin                                           
    if (rx_ready) begin
        data_shift_register [63:0]  <= rx_data; end 
    else begin
        data_shift_register [63:0]  <= data_shift_register [63:0]; end 
end
endcase
end
endmodule 