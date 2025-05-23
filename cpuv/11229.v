module sonar_driver #(parameter freq = 50_000_000) (
    input  wire      clk,        
    input  wire      rst_n,      
    input  wire      measure,    
    output reg       ready = 1,  
    output wire[7:0] distance,   
    input  wire      echo,       
    output reg       trig = 0    
);
parameter CYCLES_10_US = freq / 100_000; 
parameter CYCLE_PERIOD = 1_000_000_000 / freq; 
parameter SOUND_SPEED  = 343210; 
parameter NM_PER_CYCLE = SOUND_SPEED * CYCLE_PERIOD / 1000; 
parameter ECHO_TIMEOUT = freq / 100; 
parameter TIMEOUT      = freq; 
reg[31:0] counter = 0; 
reg[31:0] timeout = 0; 
reg[31:0] i_dist  = 0; 
reg[2:0]  state      = 0; 
reg[2:0]  next_state = 0; 
parameter IDLE       = 3'h0; 
parameter TRIG       = 3'h1; 
parameter WAIT_ECHO  = 3'h2; 
parameter MEASURING  = 3'h3; 
parameter READY      = 3'h4; 
assign distance = i_dist[31:24];
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        state = IDLE; 
    end else begin
        state = next_state; 
    end
end
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        next_state = IDLE; 
    end else begin
        case (state) 
            IDLE: begin
                if (measure == 1) begin
                    next_state = TRIG; 
                end
            end
            TRIG: begin
                if (counter == 0) begin
                    next_state = WAIT_ECHO; 
                end
            end
            WAIT_ECHO: begin
                if (echo == 1) begin
                    next_state = MEASURING; 
                end else if (timeout == 0) begin
                    next_state = READY; 
                end
            end
            MEASURING: begin
                if (echo == 0) begin
                    next_state = READY; 
                end else if (timeout == 0) begin
                    next_state = READY; 
                end
            end
            READY: begin
                next_state = IDLE; 
            end
        endcase
    end
end
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        trig    = 0;
        i_dist  = 0;
        ready   = 1;
        counter = 0;
    end else begin
        case (state) 
            IDLE: begin
                if (measure == 1) begin
                    ready   = 0;
                    counter = CYCLES_10_US; 
                    timeout = ECHO_TIMEOUT; 
                end
            end
            TRIG: begin
                i_dist  = 0;
                trig    = 1;
                counter = counter - 1; 
            end
            WAIT_ECHO: begin
                timeout = timeout - 1; 
                trig    = 0; 
            end
            MEASURING: begin
                timeout = timeout - 1; 
                i_dist = i_dist + NM_PER_CYCLE; 
            end
            READY: begin
                ready = 1; 
            end
        endcase
    end
end
endmodule