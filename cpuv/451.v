module signature_as_counter(clk, sig, f);
    `define CLK_COUNTER_SIZE 14 
    `define SIG_COUNTER_SIZE 10 
    input clk; 
    input sig; 
    output reg [13:0] f; 
    reg [13:0] n_clk; 
    reg [9:0] n_sig; 
    reg reset; 
    parameter F_CLK = 40000; 
    parameter ERR = 5; 
    parameter NUM_CNTS_AVG = F_CLK / ERR; 
    parameter F_SCALE = ERR; 
    parameter N_SIG_MAX = `SIG_COUNTER_SIZE'b1111111111; 
    initial begin
        reset = 1'b1; 
        n_clk = `CLK_COUNTER_SIZE'b0; 
        n_sig = `SIG_COUNTER_SIZE'b0; 
    end
    always @(posedge clk) begin
        if (n_clk >= NUM_CNTS_AVG) begin
            f = F_SCALE * n_sig; 
            reset = 1'b1; 
            n_clk = 1'b0; 
        end else begin
            reset = 1'b0; 
            n_clk = n_clk + `CLK_COUNTER_SIZE'b1; 
        end
    end
    always @(posedge sig or posedge reset) begin
        if (reset == 1) begin
            n_sig = `SIG_COUNTER_SIZE'b0; 
        end else if (n_sig <= N_SIG_MAX) begin
            n_sig = n_sig + `SIG_COUNTER_SIZE'b1; 
        end
    end
endmodule