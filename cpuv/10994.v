module scan_clock_timer (
    clk, 
    reset_n, 
    reset, 
    delay, 
    start, 
    done, 
    step_mode_tck, 
    go_step_tck, 
    timer_scan_state 
    );
`include "parameters_global.v" 
input clk; 
input reset_n; 
input reset; 
input [`byte_width-1:0] delay; 
input start; 
output reg done; 
input step_mode_tck; 
input go_step_tck; 
wire [3:0] multiplier; 
assign multiplier = delay[7:4]; 
wire [3:0] exponent; 
assign exponent = delay[3:0]; 
`define counter_a_width 4 
reg [`counter_a_width-1:0] counter_a; 
`define counter_b_width 26 
reg [`counter_b_width-1:0] counter_b; 
reg [`counter_b_width-1:0] counter_b_init; 
output reg [`timer_scan_state_width-1:0] timer_scan_state; 
always @(posedge clk or negedge reset_n) begin
    if (~reset_n) 
        begin
            counter_a           <= #`DEL `counter_a_width'b0; 
            counter_b           <= #`DEL `counter_b_width'b0; 
            counter_b_init      <= #`DEL `counter_b_width'b0; 
            done                <= #`DEL 0; 
            timer_scan_state    <= #`DEL TIMER_SCAN_IDLE; 
        end
    else 
        begin
            if (reset) 
                begin
                    counter_a           <= #`DEL `counter_a_width'b0; 
                    counter_b           <= #`DEL `counter_b_width'b0; 
                    counter_b_init      <= #`DEL `counter_b_width'b0; 
                    done                <= #`DEL 0; 
                    timer_scan_state    <= #`DEL TIMER_SCAN_IDLE; 
                end
            else 
                begin
                end
        end
end
endmodule