module timer(
    clk, 
    reset_n, 
    delay, 
    start, 
    reset, 
    done, 
    timer_state 
    );
    `include "parameters_global.v" 
    input clk; 
    input reset_n; 
    input reset; 
    input start; 
    input [`byte_width-1:0] delay; 
    output reg done; 
    reg [`byte_width-1:0] time_unit_count; 
    output reg [`timer_state_width-1:0] timer_state; 
    reg [`timer_counter_width-1:0] counter; 
    always @(posedge clk or negedge reset_n) begin
        if (~reset_n) 
            begin
                timer_state     <= #`DEL TIMER_STATE_IDLE; 
                counter         <= #`DEL `timer_counter_width'h0; 
                time_unit_count <= #`DEL `byte_width'h0; 
                done            <= #`DEL 0; 
            end
        else 
            begin
                if (reset) 
                    begin
                        timer_state     <= #`DEL TIMER_STATE_IDLE; 
                        counter         <= #`DEL `timer_counter_width'h0; 
                        time_unit_count <= #`DEL `byte_width'h0; 
                        done            <= #`DEL 0; 
                    end
                else 
                    begin
                        case (timer_state) 
                            TIMER_STATE_IDLE: 
                                begin
                                    done    <= #`DEL 0; 
                                    if (start) 
                                        begin
                                            timer_state <= #`DEL TIMER_STATE_1; 
                                        end
                                end
                            TIMER_STATE_1: 
                                begin
                                    if (counter == timer_ticks_for_0_1_sec_timeout) 
                                        begin
                                            counter         <= #`DEL 0; 
                                            time_unit_count <= #`DEL time_unit_count + 1; 
                                            timer_state     <= #`DEL TIMER_STATE_2; 
                                        end
                                    else 
                                        begin
                                            counter         <= #`DEL counter + 1; 
                                        end
                                end
                            TIMER_STATE_2: 
                                begin
                                    if (time_unit_count == delay) 
                                        begin
                                            done            <= #`DEL 1'b1; 
                                            time_unit_count <= #`DEL `byte_width'h0; 
                                            timer_state     <= #`DEL TIMER_STATE_IDLE; 
                                        end
                                    else 
                                        begin
                                            timer_state     <= #`DEL TIMER_STATE_1; 
                                        end
                                end
                        endcase
                    end
            end
    end
endmodule