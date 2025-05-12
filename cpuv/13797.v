module seq_utx_sm(clk, rstn, next_utx_state, done_int, done, cur_utx_state);
    input clk; 
    input rstn; 
    input [1:0] next_utx_state; 
    input done_int; 
    output reg done; 
    output reg [1:0] cur_utx_state; 
    always @(posedge clk or negedge rstn) begin
        if(rstn == 0) begin 
            done <= 0; 
            cur_utx_state <= `IDLE; 
        end else begin 
            done <= done_int; 
            cur_utx_state <= next_utx_state; 
        end
    end
endmodule