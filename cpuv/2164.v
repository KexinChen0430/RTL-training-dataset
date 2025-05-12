module lat_tester (
    input clk27,          
    input pclk,           
    input active,         
    input armed,          
    input sensor,         
    input trigger,        
    input VSYNC_in,       
    input [1:0] mode_in,  
    output reg [2:0] mode_synced,   
    output reg [15:0] lat_result,   
    output reg [11:0] stb_result,   
    output trig_waiting,  
    output reg finished   
);
reg VSYNC_in_L, VSYNC_in_LL, trigger_L, trigger_LL;
reg [8:0] clk27_ctr;
reg [1:0] state;
assign trig_waiting = (state == `LT_STATE_LAT_MEAS);
always @(posedge pclk) begin
    VSYNC_in_L <= VSYNC_in;
    VSYNC_in_LL <= VSYNC_in_L;
end
always @(posedge pclk) begin
    if (VSYNC_in_LL && !VSYNC_in_L)
        mode_synced <= mode_in;
end
always @(posedge clk27) begin
    trigger_L <= trigger;
    trigger_LL <= trigger_L;
end
always @(posedge clk27) begin
    if (!active) begin
        state <= `LT_STATE_IDLE;
    end else begin
        case (state)
            default: begin 
                finished <= 1'b0;
                lat_result <= 0;
                stb_result <= 0;
                clk27_ctr <= 0;
                if (armed && trigger_LL)
                    state <= `LT_STATE_LAT_MEAS;
            end
            `LT_STATE_LAT_MEAS: begin 
                if (sensor==0) begin
                    state <= `LT_STATE_STB_MEAS;
                    clk27_ctr <= 0;
                end else if (lat_result==16'hffff) begin
                    state <= `LT_STATE_FINISHED;
                end else begin
                    if (clk27_ctr == 270-1) begin
                        clk27_ctr <= 0;
                        lat_result <= lat_result + 1'b1;
                    end else begin
                        clk27_ctr <= clk27_ctr + 1'b1;
                    end
                end
            end
            `LT_STATE_STB_MEAS: begin 
                if (((sensor==1) && (stb_result >= 12'd100)) || (stb_result == 12'hfff)) begin
                    state <= `LT_STATE_FINISHED;
                end else begin
                    if (clk27_ctr == 270-1) begin
                        clk27_ctr <= 0;
                        stb_result <= stb_result + 1'b1;
                    end else begin
                        clk27_ctr <= clk27_ctr + 1'b1;
                    end
                end
            end
            `LT_STATE_FINISHED: begin 
                finished <= 1'b1;
                if (!armed)
                    state <= `LT_STATE_IDLE;
            end
        endcase
    end
end
endmodule