module 
    if( cache_command_i ) begin 
        if( ~cmd_i[1] ) begin 
            if( cache_pop[0] ) begin 
                small_counter <= 4'd2; 
                csn_o <= 1'b0; 
                dq_oe <= 1'b1; 
                cmd_bytes[0] <= cmd_bits[47:40];
                cmd_bytes[1] <= cmd_bits[39:32];
                cmd_bytes[2] <= cmd_bits[31:24];
                cmd_bytes[3] <= cmd_bits[23:16];
                cmd_bytes[4] <= cmd_bits[15:08];
                cmd_bytes[5] <= cmd_bits[07:00];
                state <= CSWAIT; 
            end
        end else begin 
            if( write_ptr[0] ) write_cache[write_ptr[3:1]][15:8] <= D_i[15:8];
            else write_cache[write_ptr[3:1]][7:0] <= D_i[7:0];
            write_ptr <= write_ptr + 1'b1; 
            cache_pop <= cache_pop | (1'b1<<write_ptr[3:1]); 
        end
    end else begin 
        cmd_bytes[0] <= cmd_bits[47:40];
        cmd_bytes[1] <= cmd_bits[39:32];
        cmd_bytes[2] <= cmd_bits[31:24];
        cmd_bytes[3] <= cmd_bits[23:16];
        cmd_bytes[4] <= cmd_bits[15:08];
        cmd_bytes[5] <= cmd_bits[07:00];
        small_counter <= 4'd2; 
        dq_oe <= 1'b1; 
        if( read_command ) 
        begin
            cache_line_ptr = A_i[2:0]; 
            if( ( cache_addr == {1'b0,A_i[23:3]} ) & cache_valid ) 
            begin
            end else begin 
                cache_addr <= {1'b0,A_i[23:3]}; 
                cache_ptr <= A_i[2:0]; 
                csn_o <= 1'b0; 
                state <= CSWAIT; 
            end
        end else begin 
            csn_o <= 1'b0; 
            write_cache[3'd0] <= D_i; 
            cache_ptr <= 3'd0;
            cache_pop <= 8'd0;
            write_ptr <= 4'd0;
            cache_line_ptr <= 3'd0; 
            cache_addr <= {22{1'b1}}; 
            state <= CSWAIT; 
        end
    end
    A_b <= A_i;
    D_b <= D_i;
    cmd_b <= cmd_i;
end else begin 
    csn_o <= 1'b1; 
end
endmodule 