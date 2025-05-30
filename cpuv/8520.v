module rs232_timer(
    clk, 
    reset_n, 
    start, 
    extra_delay, 
    done, 
    state 
    );
    `include "parameters_global.v" 
    input clk; 
    input reset_n; 
    input start; 
    input extra_delay; 
    output reg done; 
    output reg [`rs232_timer_state_width-1:0] state; 
    reg [`rs232_timer_counter_width-1:0] counter; 
    reg extra_delay_latch; 
    always @(posedge clk or negedge reset_n) begin
        if (~reset_n) 
            begin
                state               <= #`DEL RS232_TIMER_STATE_IDLE; 
                counter             <= #`DEL `rs232_timer_counter_width'h0; 
                done                <= #`DEL 0; 
                extra_delay_latch   <= #`DEL 0; 
            end
        else 
            begin
                case (state) 
                    RS232_TIMER_STATE_IDLE: 
                        begin
                            if (start) 
                                begin
                                    state               <= #`DEL RS232_TIMER_STATE_RUNNING; 
                                    extra_delay_latch   <= #`DEL extra_delay; 
                                end
                        end
                    RS232_TIMER_STATE_RUNNING: 
                        begin
                            if (~extra_delay_latch) 
                                begin
                                    if (counter >= rs232_delay) 
                                        begin
                                            counter         <= #`DEL 0; 
                                            state           <= #`DEL RS232_TIMER_STATE_DONE; 
                                            done            <= #`DEL 1'b1; 
                                        end
                                    else 
                                        begin
                                            counter         <= #`DEL counter + 1; 
                                        end
                                end
                            else 
                                begin
                                    if (counter >= rs232_delay + rs232_extra_delay) 
                                        begin
                                            counter         <= #`DEL 0; 
                                            state           <= #`DEL RS232_TIMER_STATE_DONE; 
                                            done            <= #`DEL 1'b1; 
                                        end
                                    else 
                                        begin
                                            counter         <= #`DEL counter + 1; 
                                        end
                                end
                        end
                    RS232_TIMER_STATE_DONE: 
                        begin
                            done            <= #`DEL 1'b0; 
                            state           <= #`DEL RS232_TIMER_STATE_IDLE; 
                        end
                endcase
            end
    end
endmodule