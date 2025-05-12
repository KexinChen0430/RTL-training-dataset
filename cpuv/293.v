module controller(
    clk, clr, in_op, c0, c1, c2, c3, c4,
    en0, en1, en2, en3, en4, en5, en6, en7,
    s1, s2
);
    input clk;       
    input clr;       
    input [3:0] in_op; 
    output reg c1, c2, c3; 
    output reg [1:0] c0, c4; 
    output en0, en1, en2, en3, en4, en5, en6, en7; 
    reg en0, en1, en2, en3, en4, en5, en6, en7; 
    output reg s2; 
    output reg [2:0] s1; 
    reg [3:0] opcode; 
    reg [5:0] curr_state; 
    reg [5:0] next_state; 
    `define SIGNALS {c0, c1, c2, c3, c4, en0, en1, en2, en3, en4, en5, en6, en7, s1, s2}
    `define ENABLES {en0, en1, en2, en3, en4, en5, en6, en7}
    initial begin
        curr_state = 6'd0; 
        next_state = 6'd0; 
        opcode = 4'bZZZZ; 
        `SIGNALS = 0; 
    end
    always @(posedge clk) begin
        curr_state = next_state; 
    end
    always @(posedge clk) begin
        if (clr) begin
            `SIGNALS = 0;
            next_state = 6'b0;
            opcode = 4'bZZZZ;
        end else begin
            opcode = in_op; 
            case (curr_state)
                6'd0 : begin
                    next_state = 6'd1;
                    en3 = 1; c3 = 1; 
                end
                6'd1 : begin
                    next_state = 6'd2;
                    en3 = 0; 
                    c0 = 1; 
                end
                6'd2 : begin
                    c3 = 0; 
                    c0 = 0; 
                    next_state = 6'd3;
                end
                6'd3 : begin
                    case (opcode)
                    endcase
                end
                6'd63 : begin
                    next_state = 6'd0;
                    `SIGNALS = 0;
                end
                default: begin
                end
            endcase
        end
    end
endmodule