module hi_get_trace(
       ck_1356megb,
       adc_d, trace_enable, major_mode,
       ssp_frame, ssp_din, ssp_clk
);
    input ck_1356megb;
    input [7:0] adc_d;
    input trace_enable;
    input [2:0] major_mode;
    output ssp_frame, ssp_din, ssp_clk;
reg [6:0] clock_cnt;
always @(negedge ck_1356megb)
begin
    clock_cnt <= clock_cnt + 1;
end
reg [2:0] sample_clock;
always @(negedge ck_1356megb)
begin
    if (sample_clock == 3'd7)
        sample_clock <= 3'd0;
    else
        sample_clock <= sample_clock + 1;
end
reg [11:0] addr;
reg [11:0] start_addr;
reg [2:0] previous_major_mode;
reg write_enable1;
reg write_enable2;
always @(negedge ck_1356megb)
begin
    previous_major_mode <= major_mode;
    if (major_mode == `FPGA_MAJOR_MODE_HF_GET_TRACE)
    begin
        write_enable1 <= 1'b0;
        write_enable2 <= 1'b0;
        if (previous_major_mode != `FPGA_MAJOR_MODE_HF_GET_TRACE) 
            addr <= start_addr;
        if (clock_cnt == 7'd0)
        begin
            if (addr == 12'd3071)
                addr <= 12'd0;
            else
                addr <= addr + 1;
        end
    end
    else if (major_mode != `FPGA_MAJOR_MODE_OFF)
    begin
        if (trace_enable)
        begin
            if (addr[11] == 1'b0)
            begin
                write_enable1 <= 1'b1;
                write_enable2 <= 1'b0;
            end
            else
            begin
                write_enable1 <= 1'b0;
                write_enable2 <= 1'b1;
            end
            if (sample_clock == 3'b000)
            begin
                if (addr == 12'd3071)
                begin
                    addr <= 12'd0;
                    write_enable1 <= 1'b1;
                    write_enable2 <= 1'b0;
                end
                else
                                begin
                    addr <= addr + 1;
                                end
            end
        end
        else
        begin
            write_enable1 <= 1'b0;
            write_enable2 <= 1'b0;
            start_addr <= addr;
        end
    end
    else 
    begin
        write_enable1 <= 1'b0;
        write_enable2 <= 1'b0;
        if (previous_major_mode != `FPGA_MAJOR_MODE_OFF && previous_major_mode != `FPGA_MAJOR_MODE_HF_GET_TRACE) 
                begin
            start_addr <= addr;
                end
    end
end
reg [7:0] D_out1, D_out2;
reg [7:0] ram1 [2047:0]; 
reg [7:0] ram2 [1023:0]; 
always @(negedge ck_1356megb)
begin
    if (write_enable1)
    begin
        ram1[addr[10:0]] <= adc_d;
        D_out1 <= adc_d;
    end
    else
        D_out1 <= ram1[addr[10:0]];
    if (write_enable2)
begin
        ram2[addr[9:0]] <= adc_d;
        D_out2 <= adc_d;
    end
    else
        D_out2 <= ram2[addr[9:0]];
end
reg ssp_clk;
reg ssp_frame;
reg [7:0] shift_out;
always @(negedge ck_1356megb)
begin
    if (clock_cnt[3:0] == 4'd0)        
    begin
        if (clock_cnt[6:4] == 3'd0)    
        begin
                    if (addr[11] == 1'b0)
                        shift_out <= D_out1;
                    else
                        shift_out <= D_out2;
        end
        else
                begin
                    shift_out[7:1] <= shift_out[6:0];
                end
    end
    ssp_clk <= ~clock_cnt[3];       
    if (clock_cnt[6:4] == 3'b000)    
        ssp_frame <= 1'b1;
    else
        ssp_frame <= 1'b0;
end
assign ssp_din = shift_out[7];
endmodule