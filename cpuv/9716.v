module to think that addresses are sequential.
            if (write_en && write_done && !write_buffer_full) begin
                r_write_address <= 32'd0; 
                r_input_data <= d;
                r_write_buffer <= 1'b1;
                r_write_en <= 1'b1;
            end else begin
                r_write_buffer <= 1'b0;
                r_write_en <= 1'b0;
            end
        end
    end
    always @(posedge CLOCK_50) begin
        if (counter < 32'd500000) begin
            r_read_en <= 1'b0;
        end else begin
        end
    end
    always @(posedge CLOCK_50) begin
        if (read_data_available && r_read_buffer == 1'b0) begin
            r_q <= output_data;
            r_read_buffer <= 1'b1;
        end else begin
            r_read_buffer <= 1'b0;
        end
    end
endmodule