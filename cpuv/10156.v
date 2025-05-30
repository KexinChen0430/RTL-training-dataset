module debouncer (clk, in, out, reset_n);
    output reg  out; 
    input       in;  
    input       clk;
    input       reset_n;
    `include "parameters_global.v"
    reg [`debouncer_counter_width-1:0] counter;
    parameter [`debouncer_counter_width-1:0]
        DEBOUNCER_STATE_IDLE        = `debouncer_counter_width'h0,
        DEBOUNCER_STATE_PRESSED     = `debouncer_counter_width'h1,
        DEBOUNCER_STATE_TRIGGERED   = `debouncer_counter_width'h2,
        DEBOUNCER_STATE_RESET       = `debouncer_counter_width'h3;
    reg [`debouncer_counter_width-1:0] debouncer_state;
    always @(posedge clk or negedge reset_n)
        begin
            if (~reset_n)
                begin
                    counter         <= #`DEL `debouncer_counter_width'b0;
                    out             <= #`DEL 1'b0;
                    debouncer_state <= #`DEL DEBOUNCER_STATE_IDLE;
                end
            else
                begin
                    case (debouncer_state)
                        DEBOUNCER_STATE_IDLE:
                            begin
                                if (in)
                                    begin
                                        debouncer_state <= #`DEL DEBOUNCER_STATE_PRESSED;
                                    end
                            end
                        DEBOUNCER_STATE_PRESSED:
                            begin
                                if (~in)
                                    begin
                                        counter         <= #`DEL `debouncer_counter_width'b0;
                                        debouncer_state <= #`DEL DEBOUNCER_STATE_IDLE;
                                    end
                                else
                                    begin
                                        counter         <= #`DEL counter + 1;
                                        if (counter == `debouncer_counter_end)
                                            begin
                                                out             <= #`DEL 1'b1;
                                                debouncer_state <= #`DEL DEBOUNCER_STATE_TRIGGERED;
                                            end
                                    end
                            end
                        DEBOUNCER_STATE_TRIGGERED:
                            begin
                                out             <= #`DEL 1'b0;
                                debouncer_state <= #`DEL DEBOUNCER_STATE_RESET;
                            end
                        DEBOUNCER_STATE_RESET:
                            begin
                                if (~in)
                                    begin
                                        counter         <= #`DEL `debouncer_counter_width'b0;
                                        debouncer_state <= #`DEL DEBOUNCER_STATE_IDLE;
                                    end
                            end
                        default:
                            begin
                                counter         <= #`DEL `debouncer_counter_width'b0;
                                debouncer_state <= #`DEL DEBOUNCER_STATE_IDLE;
                            end
                    endcase
                end
        end
endmodule