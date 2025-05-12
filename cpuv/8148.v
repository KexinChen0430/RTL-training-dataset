module fsm(clock,reset,start, a, b, contBETval, initCount, countVal, ab_result); 
input reset, clock, start; 
input signed [3:0] a,b; 
input contBETval; 
output reg initCount; 
output reg [2:0] countVal; 
output reg [1:0] currentState; 
output reg signed [7:0] ab_result; 
reg [1:0] nextState; 
reg [7:0] ab; 
initial begin 
    currentState <= 0; 
    nextState <=0; 
end
always @(posedge clock) begin 
    if (reset == 1) 
        currentState <= 2'b00; 
    else 
        currentState <= nextState; 
    `ifdef DEBUG 
        $display("fsmGB.v:18:clock ticked. currentState: %b nextState %b", currentState, nextState); 
    `endif
end
always @(*) begin 
    ab <= {a,b}; 
    case (currentState) 
        2'b00: begin 
            initCount <=0; 
            if (start==0) 
                nextState <= 2'b00; 
            else 
                nextState <= 2'b01; 
            ab_result <= 8'hFF; 
            `ifdef DEBUG 
                $display("fsmGB.v:33: start: %b ab_result %h currentState: %b nextState %b", start, ab_result, currentState, nextState); 
            `endif
        end
        2'b01: begin 
            countVal <= 5; 
            initCount <= 1; 
            ab_result <= ab; 
            if (contBETval) begin 
                if (a > b) 
                    nextState <= 2'b10; 
                else 
                    nextState <= 2'b11; 
            end else 
                nextState <= 2'b01; 
            `ifdef DEBUG 
                $display("fsmGB.v:47: ab_result: %b currentState: %b nextState %b", ab_result, currentState, nextState); 
            `endif
        end
        2'b10: begin 
            countVal <= 2; 
            initCount <= 1; 
            ab_result <= a - b; 
            if (contBETval) 
                nextState <= 2'b00; 
            else 
                nextState <= 2'b10; 
            `ifdef DEBUG 
                $display("fsmGB.v:60: ab_result: %b currentState: %b nextState %b", ab_result, currentState, nextState); 
            `endif
        end
        2'b11: begin 
            countVal <= 2; 
            initCount <= 1; 
            ab_result <= ab[7:0] ^ {1'b0, ab[7:1]}; 
            if (contBETval) 
                nextState <= 2'b00; 
            else 
                nextState <= 2'b11; 
            `ifdef DEBUG 
                $display("fsmGB.v:73: ab_result: %b currentState: %b nextState %b", ab_result, currentState, nextState); 
            `endif
        end
    endcase 
end 
endmodule 