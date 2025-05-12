module
    state_start_send: begin
        we         = 1'b1;
        tick       = 1'b1;
        next_state = state_end_send;
    end
    state_end_send : begin
        tick       = 1'b1;
        next_state = state_wait;
    end
    default : next_state = state_rst;
endcase
end
endmodule