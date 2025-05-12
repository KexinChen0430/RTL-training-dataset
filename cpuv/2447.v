module definition
    assign  writeif_accepted    = writeif_ready & writeif_valid;
    assign  buffwrite_address   = writeif_address;
    assign  buffwrite_valid     = writeif_accepted;
    assign  buffread_address    = readif_address;
    assign  buffread_valid      = readif_valid;
    always @ (*)
    begin
        if (writeif_address_blocked)
        begin
            writeif_ready = 1'b0;
        end
        else
        begin
            writeif_ready = ~&buffer_valid_counter;
        end
    end
    always @ (posedge ctl_clk or negedge ctl_reset_n)
    begin
        if (~ctl_reset_n)
        begin
            buffread_datavalid <= 0;
        end
        else
        begin
            buffread_datavalid <= buffread_valid;
        end
    end
    always @ (posedge ctl_clk or negedge ctl_reset_n)
    begin
        if (~ctl_reset_n)
        begin
            buffer_valid_counter <= 0;
            err_buffer_valid_counter_overflow <= 0;
        end
        else
        begin
            if (writeif_accepted & readif_valid)
            begin
                buffer_valid_counter <= buffer_valid_counter;
            end
            else if (writeif_accepted)
            begin
                {err_buffer_valid_counter_overflow, buffer_valid_counter} <= buffer_valid_counter + 1;
            end
            else if (readif_valid)
            begin
                buffer_valid_counter <= buffer_valid_counter - 1;
            end
            else
            begin
                buffer_valid_counter <= buffer_valid_counter;
            end
        end
    end
    function integer two_pow_N;
        input integer value;
    begin
        two_pow_N = 2 << (value-1);
    end
    endfunction
endmodule