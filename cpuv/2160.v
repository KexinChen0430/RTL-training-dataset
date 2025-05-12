module
    {3'd`STATE_EMITTING, 1'b?, 1'b1, 1'b?, 5'b0, 5'b?}:
        state <= `STATE_SIGNALLING;
    {3'd`STATE_EMITTING, 1'b?, 1'b1, 1'b?, 5'b?, 5'b?}:
        state <= `STATE_RECEIVING;
    {3'd`STATE_RECEIVING, 1'b?, 1'b?, 1'b1, 5'b?, 5'b0}:
        begin
            shiftinbuffer <= inbuffer;
            state <= `STATE_SIGNALLING;
        end
    {3'd`STATE_RECEIVING, 1'b1, 1'b?, 1'b1, 5'b?, 5'b?}:
        begin
            shiftinbuffer <= inbuffer;
            state <= `STATE_SHIFTING;
        end
    {3'd`STATE_SHIFTING, 1'b1, 1'b?, 1'b?, 5'b?, 5'b0}:
        state <= `STATE_SIGNALLING;
    {3'd`STATE_SHIFTING, 1'b1, 1'b?, 1'b?, 5'b?, 5'b?}:
        begin
            shiftinbuffer <= {shiftinbuffer[119:0],8'b0};
            toshift <= toshift - 5'd1;
        end
    endcase
always @(posedge clock or negedge reset)
    if (~reset) picready <= 0;
    else if (rts_edge) picready <= 1;
    else if (start_emitting | start_receiving) picready <= 0;
always @(posedge clock or negedge reset)
    if (~reset) begin rts_r <= 0; rts_rr <= 0; end
    else begin rts_r <= rts; rts_rr <= rts_r; end
assign inbytes = toread[4:0];
assign sclk = emit_sclk | receive_sclk;
assign irq = state == `STATE_SIGNALLING;
assign emit_enable = state == `STATE_EMITTING;
assign receive_enable = state == `STATE_RECEIVING;
assign indata = shiftinbuffer;
endmodule