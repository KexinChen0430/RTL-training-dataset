module device(
    input              clk,      
    output logic [7:0] Q, out0,  
    output logic       pass, fail, 
    input [7:0]        D, in0, in1 
);
enum logic [2:0] {IDLE, START, RUN, PASS, FAIL} state, next_state;
logic ready, next_ready;
logic next_pass, next_fail;
always_ff @(posedge clk, negedge rstn)
    if (!rstn) begin 
        state <= IDLE; 
        fail  <= 1'h0;
        pass  <= 1'h0;
        ready <= 1'h0;
    end else begin 
        state <= next_state; 
        ready <= next_ready; 
        pass  <= next_pass;  
        fail  <= next_fail;  
    end
always @* begin
    if (!ready) begin 
        out0 = 8'h0;
    end else begin 
        out0 = sel ? in1 : in0; 
    end
end
always_comb begin
    next_state = state; 
    next_fail  = 1'h0;
    next_pass  = 1'h0;
    next_ready = 1'h0;
    case (state) 
        IDLE : begin
        end
        PASS: begin
            next_state = IDLE; 
            next_pass  = 1'b1; 
            next_ready = 1'b1; 
        end
        FAIL: begin
            next_state = IDLE; 
            next_fail  = 1'b1; 
        end
    endcase
end
always_latch begin
    if (!rstn) begin 
        Q <= 8'h0;
    end else if (clk) begin 
        Q <= D; 
    end
end
endmodule 