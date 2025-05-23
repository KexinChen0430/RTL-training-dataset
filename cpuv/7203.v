module DMA(
    input reset, 
    input clk, 
    input TFC, 
    input cmd_reg_write, 
    input cmd_reg_read, 
    input Continue, 
    input TRAN, 
    input STOP, 
    input empty, 
    input full, 
    input [63:0] data_address, 
    input [15:0] length, 
    input [5:0] descriptor_index, 
    input act1, 
    input act2, 
    input END, 
    input valid, 
    input dir, 
    output start_transfer, 
    output [63:0] system_address, 
    output writing_mem, 
    output reading_mem, 
    output reading_fifo, 
    output writing_fifo, 
    output [5:0] next_descriptor_index 
);
parameter ST_STOP  = 2'b00, 
          ST_FDS   = 2'b01, 
          ST_CADR  = 2'b10, 
          ST_TFR   = 2'b11; 
reg [1:0] state; 
reg reading_fifo; 
reg writing_fifo; 
reg reading_mem; 
reg writing_mem; 
reg start_transfer; 
reg [1:0] next_state; 
reg [63:0] system_address; 
reg [5:0] next_descriptor_index; 
always @(posedge clk) begin
    if (reset) begin
        state <= ST_STOP; 
    end else begin
        state <= next_state; 
    end
end
always @(*) begin
    case (state)
        ST_STOP: begin 
            if (reset) next_state = ST_STOP; 
            else if (cmd_reg_write || Continue) next_state = ST_FDS; 
        end
        ST_FDS: begin 
            if (!valid) next_state = ST_FDS; 
            else next_state = ST_CADR; 
        end
        ST_CADR: begin 
            if (TRAN) next_state = ST_TFR; 
            else next_state = ST_CADR; 
            if (!END && !TRAN) next_state = ST_FDS; 
        end
        ST_TFR: begin 
            if (!TFC) next_state = ST_TFR; 
            else if (TFC && (END || STOP)) next_state = ST_STOP; 
            else if (TFC && (!END || !STOP)) next_state = ST_FDS; 
        end
        default: next_state = ST_STOP; 
    endcase
end 
always @(*) begin
    case (state)
        ST_STOP: begin
            start_transfer = 0; 
            system_address = data_address; 
            writing_mem = 0; 
            reading_mem = 0; 
            reading_fifo = 0; 
            writing_fifo = 0; 
        end
        ST_FDS: begin
            start_transfer = 0; 
            writing_mem = 0; 
            reading_mem = 0; 
            reading_fifo = 0; 
            writing_fifo = 0; 
            if (!valid) next_descriptor_index = descriptor_index + 1; 
        end
        ST_CADR: begin
            start_transfer = 0; 
            system_address = data_address + 1; 
            writing_mem = 0; 
            reading_mem = 0; 
            reading_fifo = 0; 
            writing_fifo = 0; 
        end
        ST_TFR: begin
            start_transfer = 1; 
            system_address = system_address; 
            writing_mem = !dir; 
            reading_mem = dir; 
            reading_fifo = !dir; 
            writing_fifo = dir; 
        end
        default: begin
            start_transfer = 0; 
            system_address = data_address; 
            writing_mem = 0; 
            reading_mem = 0; 
            reading_fifo = 0; 
            writing_fifo = 0; 
        end
    endcase
end 
endmodule 