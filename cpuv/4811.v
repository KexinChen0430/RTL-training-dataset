module i2s_out(
    input clock,         
    input reset,         
    input[15:0] left_data,  
    input[15:0] right_data, 
    output mclk,         
    output lrck,         
    output sclk,         
    output reg sdin      
);
    reg [3:0] data_pos;
    initial begin
        data_pos <= 4'b0;
    end
    assign mclk = clock;
    lrck_divider lrck_gen(
        .clock(clock),
        .reset(reset),
        .clock_out(lrck)
    );
    sclk_divider sclk_gen(
        .clock(clock),
        .reset(reset),
        .clock_out(sclk)
    );
    always @(negedge sclk) begin
        if (lrck) begin
            if (data_pos == 4'b0) begin
                sdin <= left_data[data_pos];
            end else begin
                sdin <= right_data[data_pos];
            end
        end else begin
            if (data_pos == 4'b0) begin
                sdin <= right_data[data_pos];
            end else begin
                sdin <= left_data[data_pos];
            end
        end
        data_pos <= data_pos - 1;
    end
endmodule