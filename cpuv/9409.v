STATE_RESTART: begin
    pc <= CMD_ADDRESS/8; 
    state <= STATE_FLUSHING_READS; 
end
STATE_FLUSHING_READS: begin
    if (pending_reads == 0) begin 
        fifo_sclr <= 1'b1;
        state <= STATE_CLEAR_FIFO_WAIT; 
    end
end
STATE_CLEAR_FIFO_WAIT: begin
    fifo_sclr <= 1'b0; 
    state <= STATE_COPY_COMMANDS; 
end
STATE_COPY_COMMANDS: begin
    if (read_read && read_waitrequest) begin 
    end else if (fifo_size + pending_reads < FIFO_DEPTH - 3) begin 
        read_address <= pc; 
        read_read <= 1'b1; 
        pc <= pc + 1'b1; 
        if (read_readdatavalid) begin 
            pending_reads <= pending_reads;
        end else begin 
            pending_reads <= pending_reads + 1'b1;
        end
    end else begin 
        read_read <= 1'b0;
    end
end
default: begin
    state <= STATE_INIT;
end