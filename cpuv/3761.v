module tmu2_hdiv(
    input sys_clk,
    input sys_rst,
    output busy,
    input pipe_stb_i,
    output reg pipe_ack_o,
    input signed [11:0] x,
    input signed [11:0] y,
    input signed [17:0] tsx,
    input signed [17:0] tsy,
    input diff_x_positive,
    input diff_y_positive,
    input [16:0] diff_x,
    input [16:0] diff_y,
    input [10:0] dst_squarew,
    output reg pipe_stb_o,
    input pipe_ack_i,
    output reg signed [11:0] x_f,
    output reg signed [11:0] y_f,
    output reg signed [17:0] tsx_f,
    output reg signed [17:0] tsy_f,
    output reg diff_x_positive_f,
    output reg diff_y_positive_f,
    output [16:0] diff_x_q,
    output [16:0] diff_x_r,
    output [16:0] diff_y_q,
    output [16:0] diff_y_r
);
reg start;
wire ready;
tmu2_divider17 d_x(
    .sys_clk(sys_clk),
    .sys_rst(sys_rst),
    .start(start),
    .dividend(diff_x),
    .divisor({6'd0, dst_squarew}), 
    .ready(ready),                 
    .quotient(diff_x_q),           
    .remainder(diff_x_r)           
);
tmu2_divider17 d_y(
    .sys_clk(sys_clk),
    .sys_rst(sys_rst),
    .start(start),
    .dividend(diff_y),
    .divisor({6'd0, dst_squarew}), 
    .ready(),                      
    .quotient(diff_y_q),           
    .remainder(diff_y_r)           
);
always @(posedge sys_clk) begin
    if(start) begin
        x_f <= x;
        y_f <= y;
        tsx_f <= tsx;
        tsy_f <= tsy;
        diff_x_positive_f <= diff_x_positive;
        diff_y_positive_f <= diff_y_positive;
    end
end
reg state;
reg next_state;
parameter IDLE = 1'b0;
parameter WAIT = 1'b1;
always @(posedge sys_clk) begin
    if(sys_rst)
        state = IDLE; 
    else
        state = next_state; 
end
assign busy = state;
always @(*) begin
    next_state = state; 
    start = 1'b0;       
    pipe_stb_o = 1'b0;  
    pipe_ack_o = 1'b0;  
    case(state)
        IDLE: begin
            pipe_ack_o = 1'b1; 
            if(pipe_stb_i) begin
                start = 1'b1;       
                next_state = WAIT;  
            end
        end
        WAIT: begin
            if(ready) begin
                pipe_stb_o = 1'b1; 
                if(pipe_ack_i)
                    next_state = IDLE; 
            end
        end
    endcase
end
endmodule